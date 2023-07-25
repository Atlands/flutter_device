package com.qc.device.utils.device

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.wifi.WifiManager
import androidx.core.content.ContextCompat
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil

@SuppressLint("HardwareIds")
fun DeviceUtil.getWifi(): Device.WifiInfo? {

    if (ContextCompat.checkSelfPermission(
            activity,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) != PackageManager.PERMISSION_GRANTED
    ) return null

    val manager =
        activity.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            ?: return null

    if (manager.wifiState != WifiManager.WIFI_STATE_ENABLED) return null
    val info = manager.connectionInfo

    return Device.WifiInfo(
//        ip = info.ipAddress,
        ssid = info.ssid,
        bssid = info.bssid,
//        capabilities = info.ca
        macAddress = info.macAddress,
        rssi = info.rssi,
        frequency = info.frequency,
    )
}

fun DeviceUtil.getWifiList(registered: Boolean): List<Device.WifiInfo> {
    if (ContextCompat.checkSelfPermission(
            activity,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) != PackageManager.PERMISSION_GRANTED
    ) return emptyList()

    val manager =
        activity.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            ?: return emptyList()
    return if (registered) manager.configuredNetworks.map {
        Device.WifiInfo(
            ssid = it.SSID,
            bssid = it.BSSID
        )
    }
    else
        manager.scanResults.map {
            Device.WifiInfo(
                ssid = it.BSSID,
                bssid = it.BSSID,
                capabilities = it.capabilities,
                rssi = it.level,
                frequency = it.frequency,
                timestamp = it.timestamp
            )
        }
}
//
//private fun isWifiConnection(context: Context): Boolean {
//
//    val manager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager ?: return true
//    val networkInfo = manager.activeNetworkInfo ?: return true
//    return networkInfo.type == ConnectivityManager.TYPE_WIFI
//}