package com.qc.device.utils.device

import android.content.Context
import android.content.res.Resources
import android.provider.Settings
import android.view.WindowManager
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil

fun DeviceUtil.getScreen(): Device.Screen {
    val displayMetrics = Resources.getSystem().displayMetrics
    val brightness =
        Settings.System.getInt(activity.contentResolver, Settings.System.SCREEN_BRIGHTNESS, 125)
    //TODO: display, physicalSize
    return Device.Screen(
        width = displayMetrics.widthPixels,
        height = displayMetrics.heightPixels,
        resolution = "${displayMetrics.widthPixels}*${displayMetrics.heightPixels}",
        density = displayMetrics.density,
        dpi = displayMetrics.densityDpi,
        brightness = brightness
    )
}

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
//            val windowMetrics = manager.currentWindowMetrics
//            width = windowMetrics.bounds.width()
//            height = windowMetrics.bounds.height()
//
//        } else {
//            val displayMetrics = DisplayMetrics()
//            manager.defaultDisplay.getMetrics(displayMetrics)
//            width = displayMetrics.widthPixels
//            height = displayMetrics.heightPixels
//        }
//    }