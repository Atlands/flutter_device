package com.qc.device.utils.device

import android.os.Build
import android.util.Log
import java.io.IOException
import java.io.InputStreamReader
import java.io.LineNumberReader
import java.net.NetworkInterface
import java.util.Collections


fun getMac(): String {
    var mac = if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.M) {
        getMacAddress().ifBlank { getMacFromHardware() }
    } else {
        getMacFromHardware()
    }
    if (mac.isBlank() || mac == "58:02:03:04:05:06") mac = "02:00:00:00:00:00"
    Log.e("Mac mac", mac)
    return mac
}

/**
 * Android 6.0-Android 7.0 获取mac地址
 */
private fun getMacAddress(): String {
    var macSerial: String? = null

    try {
        val pp = Runtime.getRuntime().exec("cat/sys/class/net/wlan0/address")
        val ir = InputStreamReader(pp.inputStream)
        val input = LineNumberReader(ir)
        var strLine = ""
        while (strLine.isBlank()) {
            strLine = input.readLine() ?: ""
            if (strLine.isNotBlank()) {
                macSerial = strLine.trim { it <= ' ' } //去空格
                break
            }
        }
    } catch (ex: IOException) {
        // 赋予默认值
        ex.printStackTrace()
    }
    return macSerial ?: ""
}

/**
 * Android 7 以上
 */
private fun getMacFromHardware(): String {
    return try {
        val all = Collections.list(NetworkInterface.getNetworkInterfaces())
        for (nif in all) {
            if (!nif.name.equals("wlan0", ignoreCase = true))
                continue
            val macBytes = nif.hardwareAddress ?: return ""
            val stringBuilder = StringBuffer()
            for (byte in macBytes) {
                stringBuilder.append(String.format("%02X:", byte))
            }
            if (stringBuilder.isNotBlank())
                stringBuilder.deleteCharAt(stringBuilder.length - 1)
            return stringBuilder.toString()
        }
        ""
    } catch (e: Exception) {
        e.printStackTrace()
        ""
    }
}