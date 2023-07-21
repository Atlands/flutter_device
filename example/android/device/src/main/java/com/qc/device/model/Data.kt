package com.qc.device.model

interface DataID{
    val id: String
}

interface DataDate {
    val createdAt: Long
    val updatedAt: Long
}

interface DataDateString{
    val createdAt: String
    val updatedAt: String
}