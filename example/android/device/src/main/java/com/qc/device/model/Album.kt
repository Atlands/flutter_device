package com.qc.device.model

data class Album(
    override val id: String,
    override val createdAt: Long,
    override val updatedAt: Long
) : DataID, DataDate
