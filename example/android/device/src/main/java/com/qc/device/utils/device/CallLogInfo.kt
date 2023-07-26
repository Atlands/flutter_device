package com.qc.device.utils.device

import com.google.gson.annotations.SerializedName

data class CallLogInfo(
    @SerializedName("type") val type: Int,
    @SerializedName("other_name") val name: String,
    @SerializedName("other_mobile") val phone: String,
    @SerializedName("duration") val duration: Int,
    @SerializedName("time") val creartedAt: String,
)