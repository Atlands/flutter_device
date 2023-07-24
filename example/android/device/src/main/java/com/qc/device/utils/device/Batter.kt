package com.qc.device.utils.device

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil
import java.lang.Exception

fun DeviceUtil.getBatter(context: Context) : Device.Batter? {
    val intent: Intent = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
        context.registerReceiver(null, ifilter)
    } ?: return null
    val batteryStatus = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
    val batteryHealth = intent.getIntExtra(BatteryManager.EXTRA_HEALTH, -1)
    val batteryPlugged = intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
    val existed = intent.getBooleanExtra(BatteryManager.EXTRA_PRESENT, false)
    val technology = intent.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY) ?: ""
    val temperature = intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
    val nowCapacity = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
    val maxCapacity = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)

    val level = try {
        nowCapacity.toDouble() / maxCapacity.toDouble()
    } catch (e: Exception) {
        0.0
    }
    return Device.Batter(
        existed = existed,
        status = batteryStatus,
        health = batteryHealth,
        chargeType = batteryPlugged,
        nowCapacity = nowCapacity,
        maxCapacity = maxCapacity,
        level = level,
        technology = technology,
        temperature = temperature
    )
}