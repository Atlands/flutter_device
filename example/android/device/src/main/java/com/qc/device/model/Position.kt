package com.qc.device.model

data class Position(
    val latitude: Double,
    val longitude: Double,
    val address: String,
    val province: String,
    val city: String,
    val street: String,
    val createdAt: Long,
)
