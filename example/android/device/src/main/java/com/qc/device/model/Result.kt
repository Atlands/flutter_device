package com.qc.device.model

import com.google.gson.annotations.SerializedName


data class Result<T>(
    @SerializedName("code") val code: Long,
    @SerializedName("message") val message: String? = null,
    @SerializedName("data") val data: T,
)
