package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Referrer(
    @SerializedName("referrer") val referrer: String,
    @SerializedName("download_time") val installDate: String,
)