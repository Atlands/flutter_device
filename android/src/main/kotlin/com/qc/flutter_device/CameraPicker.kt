package com.qc.flutter_device

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.qc.device.model.Result
import com.qc.device.model.ResultError
import id.zelory.compressor.Compressor
import id.zelory.compressor.constraint.quality
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import java.io.File
import java.util.UUID

class CameraPicker(private val activity: ComponentActivity) {
    private var onResult: ((Result<String?>) -> Unit)? = null
    private var font = false

    //    private var photoUri: Uri? = null
    private var photoFilePath: String? = null
    private val scope = CoroutineScope(Dispatchers.IO)

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
                scope.launch {
                    val path = try {
                        val compressedImageFile =
                            Compressor.compress(activity, File(photoFilePath!!)) {
                                quality(40)
                                size(204800)
                            }
                        compressedImageFile.path

                    } catch (e: Exception) {
                        photoFilePath
                    }

                    onResult?.invoke(Result(ResultError.RESULT_OK, null, path))

                    onResult = null
                    photoFilePath = null
                }

            } else {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, photoFilePath))

                onResult = null
                photoFilePath = null
            }
        }


    fun picker(font: Boolean = false, onResult: (Result<String?>) -> Unit) {
        this.onResult = onResult
        this.font = font

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
        if (font) {
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

class CameraPickerFileProvider: FileProvider()