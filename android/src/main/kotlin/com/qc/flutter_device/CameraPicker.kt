package com.qc.flutter_device

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.qc.device.model.Result
import java.io.File
import java.util.UUID

class CameraPicker(private val activity: ComponentActivity) {
    private var onResult: ((Result<String?>) -> Unit)? = null
    private var font = false

    //    private var photoUri: Uri? = null
    private var photoFilePath: String? = null

    private var permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                takePicture()
            } else {
                onResult?.invoke(Result(1002, "camera permission denied", null))
                onResult = null
            }
        }

    private val cameraIntent =
        activity.registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK) {
                photoFilePath?.let { path ->
                    onResult?.invoke(Result(200, null, path))
                }
            }
            onResult = null
            photoFilePath = null
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
        val storageFile: File =
            if (Environment.MEDIA_MOUNTED == Environment.getExternalStorageState()) {
                activity.externalCacheDir
            } else {
                activity.cacheDir
            } ?: return null
        val photoFile = File.createTempFile("${UUID.randomUUID()}", ".png", storageFile).apply {
            createNewFile()
            deleteOnExit()
        }
        photoFilePath = photoFile.path
        return FileProvider.getUriForFile(
            activity,
            "com.cd.cashdoor.provider",
            photoFile
        )
    }
}