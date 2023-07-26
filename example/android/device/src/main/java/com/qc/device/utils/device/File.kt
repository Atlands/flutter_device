package com.qc.device.utils.device

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.ContactsContract
import android.provider.MediaStore
import androidx.core.content.ContextCompat
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil
import com.qc.device.utils.string
import java.io.File


fun DeviceUtil.getFiles(): Device.File {
    return Device.File(
        imageInternal = getImagesInternal(activity).size,
        imageExternal = getImagesExternal(activity).size,
        audioInternal = getAudioInternal(activity).size,
        audioExternal = getAudioExternal(activity).size,
        videoInternal = getVideoInternal(activity).size,
        videoExternal = getVideoExternal(activity).size,
        downloadInternal = 0,
        downloadExternal = getDownloadFile(activity).size,
        contactGroup = getContactGroup(activity)
    )
}

private fun getContactGroup(context: Context): Int {
    val key = Manifest.permission.READ_CONTACTS
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return 0
    val cursor = context.contentResolver.query(
        ContactsContract.Groups.CONTENT_URI,
        arrayOf(ContactsContract.Groups._ID, ContactsContract.Groups.TITLE),
        null,
        null,
        null
    ) ?: return 0
    var count = 0
    while (cursor.moveToNext()) {
        count++
    }
    cursor.close()
    return count
}

private fun getAudioInternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_AUDIO
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Audio.Media.INTERNAL_CONTENT_URI
    )
}

private fun getAudioExternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_AUDIO
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
    )
}

private fun getVideoInternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_VIDEO
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Video.Media.INTERNAL_CONTENT_URI
    )
}

private fun getVideoExternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_VIDEO
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Video.Media.EXTERNAL_CONTENT_URI
    )
}

private fun getImagesInternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_IMAGES
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Images.Media.INTERNAL_CONTENT_URI
    )
}

private fun getImagesExternal(context: Context): List<File> {
    val key =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
            Manifest.permission.READ_MEDIA_IMAGES
        else
            Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return getFiles(
        context,
        MediaStore.Images.Media.EXTERNAL_CONTENT_URI
    )
}

private fun getDownloadFile(context: Context): List<File> {
    val key = Manifest.permission.READ_EXTERNAL_STORAGE
    if (ContextCompat.checkSelfPermission(
            context,
            key
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
        getFiles(
            context,
            MediaStore.Downloads.EXTERNAL_CONTENT_URI
        )
    } else {
        val path =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).absolutePath
        val dir = File(path)
        val files = dir.listFiles()
        files?.toList() ?: emptyList()
    }
}


/**
 * 获取所有文件
 */
private fun getFiles(context: Context, volumeName: Uri): List<File> {
    val files = mutableListOf<File>()
    // 扫描files文件库
    val mContentResolver = context.contentResolver
    val cursor: Cursor = mContentResolver.query(
        volumeName,
        null,
        null,
        null,
        null
    ) ?: return files
    while (cursor.moveToNext()) {
        val path = cursor.string(MediaStore.Files.FileColumns.DATA)
        if (path.lastIndexOf(".") == -1) continue
        if (path.lastIndexOf(File.separator) == -1) continue
        val file = File(path)
        files.add(file)
    }
    cursor.close()
    return files
}