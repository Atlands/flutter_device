package com.qc.device.utils

import android.annotation.SuppressLint
import android.content.Context
import android.provider.Settings
import androidx.activity.ComponentActivity

class DeviceUtil(val activity: ComponentActivity) {
    @SuppressLint("HardwareIds")
    fun getAndroidID(): String =
        try {
            Settings.Secure.getString(activity.contentResolver, Settings.Secure.ANDROID_ID) ?: ""
        } catch (e: Exception) {
            e.printStackTrace()
            ""
        }
}