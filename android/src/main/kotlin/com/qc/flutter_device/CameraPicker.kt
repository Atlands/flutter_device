package com.qc.flutter_device

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.lifecycle.lifecycleScope
import com.qc.device.model.Result
import com.qc.device.model.ResultError
import kotlinx.coroutines.launch
import java.io.File
import java.util.UUID

data class ImageOption(
    val maxWidth: Double?,
    val maxHeight: Double?,
    val imageQuality: Int,
    val front: Boolean,
)

class CameraPicker(private val activity: ComponentActivity) {
    private var onResult: ((Result<String?>) -> Unit)? = null
    private var imageOption = ImageOption(null, null, 100, false)

    private var photoFilePath: String? = null
    private val imageResizer = ImageResizer(activity, ExifDataCopier())

    private var permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                takePicture()
            } else {
                onResult?.invoke(
                    Result(
                        ResultError.CAMERA_PERMISSION,
                        "camera permission denied",
                        null
                    )
                )
                onResult = null
            }
        }

    private val cameraIntent =
        activity.registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK && photoFilePath != null) {
                activity.lifecycleScope.launch {

                    val path = imageResizer.resizeImageIfNeeded(
                        photoFilePath,
                        imageOption.maxWidth,
                        imageOption.maxHeight,
                        imageOption.imageQuality
                    )

                    onResult?.invoke(Result(ResultError.RESULT_OK, null, path))

                    onResult = null
                    photoFilePath = null
                }

            } else {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, null))

                onResult = null
                photoFilePath = null
            }
        }


    fun picker(imageOption: ImageOption, onResult: (Result<String?>) -> Unit) {
        this.onResult = onResult
        this.imageOption = imageOption

        if (ContextCompat.checkSelfPermission(
                activity,
                Manifest.permission.CAMERA
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            takePicture()
        } else {
            permission.launch(Manifest.permission.CAMERA)
        }
    }

    private fun takePicture() {
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        if (imageOption.front) {
            intent.putExtra("android.intent.extras.CAMERA_FACING", 1)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                intent.putExtra("android.intent.extra.USE_FRONT_CAMERA", true)
            }
        } else {
            intent.putExtra("android.intent.extras.CAMERA_FACING", 0)
            intent.putExtra("android.intent.extra.USE_FRONT_CAMERA", false)
        }
        val photoUri = getPhotoFileUri()
        intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri)
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        cameraIntent.launch(intent)
    }

    private fun getPhotoFileUri(): Uri? {
        val storageFile: File = activity.cacheDir
        val photoFile = File.createTempFile("${UUID.randomUUID()}", ".jpeg", storageFile).apply {
            createNewFile()
            deleteOnExit()
        }
        photoFilePath = photoFile.path
        return FileProvider.getUriForFile(
            activity,
            "${activity.packageName}.camera.provider",
            photoFile
        )
    }
}

class CameraPickerFileProvider : FileProvider()