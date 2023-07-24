package com.qc.device.utils.device

import android.os.Build
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil
import java.io.File

fun DeviceUtil.getCPU(): Device.CPU {
    val cpuName: String? =
        File("/proc/cpuinfo").readLines().find { it.startsWith("Hardware") }?.substringAfter(":")
            ?.trim()
    val cores: Int =
        File("/sys/devices/system/cpu/").listFiles { file -> file.name.matches(Regex("cpu\\d+")) }?.size
            ?: 1
    val frequencyMin: Long? =
        File("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq").readText().toLongOrNull()
    val frequencyMax: Long? =
        File("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq").readText().toLongOrNull()
//    val architecture: String? =
//        File("/proc/cpuinfo").readLines().find { it.startsWith("Processor") }?.substringAfter(":")
//            ?.trim()
    val abis = Build.SUPPORTED_ABIS.toList()
    return Device.CPU(
        name = cpuName,
        cores = cores,
        frequencyMin = frequencyMin,
        frequencyMax = frequencyMax,
//        architecture = architecture,
        abis = abis
    )
}