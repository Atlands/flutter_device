package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Photo(
    @SerializedName("name") val name: String? = null,
    @SerializedName("author") val author: String? = null,
    @SerializedName("addTime") val createdAt: String? = null,
    @SerializedName("updateTime") val updatedAt: String? = null,
    @SerializedName("model") val model: String? = null,
    @SerializedName("width") val width: Int? = null,
    @SerializedName("height") val height: Int? = null,
    @SerializedName("longitude") var longitude: Double? = null,
    @SerializedName("latitude") var latitude: Double? = null,
    @SerializedName("orientation") val orientation: String? = null,
    @SerializedName("x_resolution") val resolutionX: String? = null,
    @SerializedName("y_resolution") val resolutionY: String? = null,
    @SerializedName("altitude") val altitude: String? = null,
    @SerializedName("gps_processing_method") val gpsProcessingMethod: String? = null,
    @SerializedName("lens_make") val lensMake: String? = null,
    @SerializedName("lens_model") val lensModel: String? = null,
    @SerializedName("focal_length") val focalLength: String? = null,
    @SerializedName("flash") val flash: String? = null,
    @SerializedName("software") val software: String? = null,
    @SerializedName("latitude_ref") val latitudeRef: String? = null,
    @SerializedName("longitude_ref") val longitudeRef: String? = null,
)
