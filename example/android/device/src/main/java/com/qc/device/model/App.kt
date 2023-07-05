package com.qc.device.model

data class App(
    val appName: String,
    val packageName: String,
    val isSystem: Boolean,
    val version: String,
    val versionCode: Int,
    override val createdAt: Long,
    override val updatedAt: Long,
): DataDate
