package com.qc.device.model

data class Contact(
    override val id: String,
    val displayName: String,
    val familyName: String,
    val giveName: String,
    val phone: String,
    override val updatedAt: Long,
    override val createdAt: Long = 0
) : DataID, DataDate

