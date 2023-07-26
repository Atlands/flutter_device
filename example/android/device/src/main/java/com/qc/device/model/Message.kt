package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Message(
    @SerializedName("other_name") val name: String,
    @SerializedName("other_mobile") val phone: String,
    @SerializedName("content") val content: String,
    @SerializedName("time") val time: String,
    @SerializedName("type") var type: Int,
    @SerializedName("read") val read: Int,
)
