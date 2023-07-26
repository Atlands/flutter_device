package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Position(
    @SerializedName("position_x") val latitude: Double? = null,
    @SerializedName("position_y") val longitude: Double? = null,
    @SerializedName("location") var address: String? = null,
    @SerializedName("geo_time") var geo_time: String? = null,
    @SerializedName("gps_address_province") var gps_address_province: String? = null,
    @SerializedName("gps_address_city") var gps_address_city: String? = null,
    @SerializedName("gps_address_street") var gps_address_street: String ? = null,
)
