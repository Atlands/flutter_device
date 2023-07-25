package com.qc.device.utils.device

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil

fun DeviceUtil.getSensorList(): List<Device.SensorInfo> {
    val manager =
        activity.getSystemService(Context.SENSOR_SERVICE) as? SensorManager ?: return emptyList()
    return manager.getSensorList(Sensor.TYPE_ALL).map {
        Device.SensorInfo(
            type = it.type,
            name = it.name,
            version = it.version,
            vendor = it.vendor,
            maxRange = it.maximumRange,
            minDelay = it.minDelay,
            power = it.power,
            resolution = it.resolution
        )
    }
}