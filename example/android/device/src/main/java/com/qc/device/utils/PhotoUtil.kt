package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import androidx.exifinterface.media.ExifInterface
import android.os.Build
import android.provider.MediaStore
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Photo
import com.qc.device.model.ResultError
import com.qc.device.model.Result

class PhotoUtil(val activity: ComponentActivity) {
    private val allPhotos = mutableListOf<Photo>()
    private var startTimestamp: Long = 0
    private var onResult: ((Result<List<Photo>>) -> Unit)? = null

    private val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, allPhotos()))
            } else {
                onResult?.invoke(
                    Result(
                        ResultError.STORAGE_PERMISSION,
                        "storage permission denied",
                        emptyList()
                    )
                )
            }
            onResult = null
        }

    fun getPhotos(startTimestamp: Long = 0, onResult: (Result<List<Photo>>) -> Unit) {
        this.startTimestamp = startTimestamp
        this.onResult = onResult
        val key =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
                Manifest.permission.READ_MEDIA_AUDIO
            else
                Manifest.permission.READ_EXTERNAL_STORAGE
        if (ContextCompat.checkSelfPermission(activity, key) == PackageManager.PERMISSION_GRANTED) {
            this.onResult?.invoke(Result(ResultError.RESULT_OK, null, allPhotos()))
            this.onResult = null
        } else {
            permission.launch(key)
        }
    }

    private fun allPhotos(): List<Photo> {
        if (allPhotos.isNotEmpty()) return allPhotos
        val where =
            "( ${MediaStore.Images.Media.MIME_TYPE} =? " +
                    "or ${MediaStore.Images.Media.MIME_TYPE} =? " +
                    "or ${MediaStore.Images.Media.MIME_TYPE} =? ) " +
                    "and ${MediaStore.Images.Media.DATE_MODIFIED} > ${startTimestamp / 1000}"
        val whereArgs = arrayOf("image/jpeg", "image/png", "image/jpg")
        val cursor = activity.contentResolver.query(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            null,
            where,
            whereArgs,
            null
        ) ?: return allPhotos
        val exifInterface = try {
            val path = cursor.string(MediaStore.Images.Media.DATA)
            ExifInterface(path)
        } catch (_: Exception) {
            null
        }
        val author = (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            cursor.string(MediaStore.Images.Media.AUTHOR)
        else "").ifBlank { Build.BRAND }
        val latitude: Double = cursor.double(MediaStore.Images.Media.LATITUDE).let {
            if (it == 0.0) exifInterface?.getAttributeDouble(ExifInterface.TAG_APERTURE_VALUE, 0.0)
                ?: 0.0
            else it
        }
        val longitude = cursor.double(MediaStore.Images.Media.LONGITUDE).let {
            if (it == 0.0) exifInterface?.getAttributeDouble(ExifInterface.TAG_GPS_LONGITUDE, 0.0)
                ?: 0.0
            else it
        }
        while (cursor.moveToNext()) {
            allPhotos.add(
                Photo(
                    name = cursor.string(MediaStore.Images.Media.DISPLAY_NAME),
                    width = cursor.int(MediaStore.Images.Media.WIDTH),
                    height = cursor.int(MediaStore.Images.Media.HEIGHT),
                    author = author,
                    createdAt = (cursor.long(MediaStore.Images.Media.DATE_ADDED) * 1000).formatDate(),
                    updatedAt = (cursor.long(MediaStore.Images.Media.DATE_MODIFIED) * 1000).formatDate(),
                    model = Build.MODEL,
                    latitude = latitude,
                    longitude = longitude,
                    orientation = exifInterface?.getAttribute(ExifInterface.TAG_ORIENTATION),
                    resolutionX = exifInterface?.getAttribute(ExifInterface.TAG_X_RESOLUTION),
                    resolutionY = exifInterface?.getAttribute(ExifInterface.TAG_Y_RESOLUTION),
                    altitude = exifInterface?.getAttribute(ExifInterface.TAG_GPS_ALTITUDE),
                    gpsProcessingMethod = exifInterface?.getAttribute(ExifInterface.TAG_GPS_PROCESSING_METHOD),
                    lensMake = exifInterface?.getAttribute(ExifInterface.TAG_MAKE),
                    lensModel = exifInterface?.getAttribute(ExifInterface.TAG_MODEL),
                    focalLength = exifInterface?.getAttribute(ExifInterface.TAG_FOCAL_LENGTH),
                    flash = exifInterface?.getAttribute(ExifInterface.TAG_FLASH),
                    software = exifInterface?.getAttribute(ExifInterface.TAG_SOFTWARE),
                    latitudeRef = exifInterface?.getAttribute(ExifInterface.TAG_GPS_LATITUDE_REF),
                    longitudeRef = exifInterface?.getAttribute(ExifInterface.TAG_GPS_LONGITUDE_REF)
                )
            )
        }
        cursor.close()
        return allPhotos
    }
}