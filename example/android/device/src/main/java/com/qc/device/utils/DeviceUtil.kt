package com.qc.device.utils

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.provider.Settings
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Device

class DeviceUtil(val activity: ComponentActivity) {
    private var onResult: ((Result<Device>) -> Unit)? = null

//    fun getDevice():Device{
//
//        return Device()
//    }
    @SuppressLint("HardwareIds")
    fun getAndroidID(): String =
        try {
            Settings.Secure.getString(activity.contentResolver, Settings.Secure.ANDROID_ID) ?: ""
        } catch (e: Exception) {
            e.printStackTrace()
            ""
        }
}