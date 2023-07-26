package com.qc.device.utils.device

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.SystemClock
import android.provider.Settings
import android.telephony.TelephonyManager
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil
import java.io.File

fun DeviceUtil.getDeviceInfo(): Device.DeviceInfo {
    return Device.DeviceInfo(
        name = Build.PRODUCT,
        brand = Build.BRAND,
        model = Build.MODEL,
        serial = Build.SERIAL,
        androidId = getAndroidID(),
        imei = "",
        imsi = "",
        meid = "",
        gaid = getGoogleId(activity),
        gsfid = "",
        buildId = Build.ID,
        buildNumber = Build.VERSION.SDK_INT,
        buildTime = Build.TIME,
        version = Build.DISPLAY,
        macAddress = getMac(),
        isRooted = isRoot(),
        isSimulator = isEmulator(activity),
        isUSBDebug = isOpenUSBDebug(activity),
        isGpsFaked = false,
        updateMills = SystemClock.uptimeMillis(),
        elapsedRealtime = SystemClock.elapsedRealtime(),
        lastBootTime = 0,
        baseBandVersion = "",
        kernelVersion = "",
        physicalKeyboard = false,
        keyboard = "",
        bluetoothCount = 0, bluetoothMac = "",
        radioVersion = "",
        board = Build.BOARD,
        buildFingerprint = Build.FINGERPRINT,
        ringerMode = 0,
        isAirplane = false,
        host = Build.HOST,
        manufacturerName = ""
    )
}

private fun isOpenUSBDebug(context: Context): Boolean = try {
    Settings.Secure.getInt(context.contentResolver, Settings.Secure.ADB_ENABLED, 0) > 0
} catch (e: Exception) {
    e.printStackTrace()
    false
}

/**
 * 判断是否模拟器
 */
@SuppressLint("HardwareIds")
private fun isEmulator(context: Context): Boolean = try {
    val url = "tel:" + "123456"
    val intent = Intent()
    intent.data = Uri.parse(url)
    intent.action = Intent.ACTION_DIAL
    // 是否可以处理跳转到拨号的 Intent
    val canCallPhone = intent.resolveActivity(context.packageManager) != null
    Build.FINGERPRINT.startsWith("generic") || Build.FINGERPRINT.lowercase()
        .contains("vbox") || Build.FINGERPRINT.lowercase()
        .contains("test-keys") || Build.MODEL.contains("google_sdk") || Build.MODEL.contains(
        "Emulator"
    ) || Build.MODEL
        .contains("MuMu") || Build.MODEL.contains("virtual") || Build.SERIAL.equals(
        "android",
        ignoreCase = true
    ) || Build.MANUFACTURER
        .contains("Genymotion") || Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith(
        "generic"
    ) || ("google_sdk"
            == Build.PRODUCT) || ((context
        .getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager).networkOperatorName
        .lowercase()
            == "android") || !canCallPhone
} catch (e: Exception) {
    e.printStackTrace()
    false
}

/**
 * 是否root
 */
private fun isRoot(): Boolean {
    return try {
        !(!File("/system/bin/su").exists() &&
                !File("/system/xbin/su").exists())
    } catch (e: Exception) {
        false
    }
}

private fun getGoogleId(context: Context): String =
    try {
        val adInfo: AdvertisingIdClient.Info =
            AdvertisingIdClient.getAdvertisingIdInfo(context)
        adInfo.id ?: ""
    } catch (e: java.lang.Exception) {
        e.printStackTrace()
        ""
    }