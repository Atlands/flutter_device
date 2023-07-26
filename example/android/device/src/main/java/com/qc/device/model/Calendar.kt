package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Calendar(
    @SerializedName("id") val id: Long,
    @SerializedName("event_title") val eventTitle: String,
    @SerializedName("description") val description: String,
    @SerializedName("start_time") val startTime: String,
    @SerializedName("end_time") val endTime: String,
)
