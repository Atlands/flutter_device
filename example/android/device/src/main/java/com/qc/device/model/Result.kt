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
    const val CONTACT_PERMISSION = 100003
    const val STORAGE_PERMISSION = 100004
    const val MESSAGE_PERMISSION = 100005
    const val CALENDAR_PERMISSION = 100006
    const val LOCATION_PERMISSION = 100007
    const val CALL_LOG_PERMISSION = 100008
    const val REFERRER_ERROR = 100009
}