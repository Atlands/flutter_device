package com.qc.device.model

import com.google.gson.annotations.SerializedName


data class Result<T>(
    @SerializedName("code") val code: Int,
    @SerializedName("message") val message: String? = null,
    @SerializedName("data") val data: T,
)


object  ResultError{
    const val RESULT_OK = 200
    const val PACKAGE_EXCEPTION = 100001
    const val CAMERA_PERMISSION = 100002
}