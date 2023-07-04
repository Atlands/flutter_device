package com.qc.device.model

data class Contact(
    override val id: String,
    val displayName: String,
    val familyName: String,
    val giveName: String,
    val phone: String,
    val updatedAt: Long
) : Data(id)

