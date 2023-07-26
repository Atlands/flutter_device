package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class App(
    /**
     * 应用名称
     */
    @SerializedName("name") val name: String,

    /**
     * 安装时间
     */
    @SerializedName("firstTime") val createdAt: Long? = null,

    /**
     * 是否系统应用
     */
//    @SerializedName("systemApp")  val isSystem: Boolean = false,
    @SerializedName("systemApp") val isSystem: Int = 0,

    /**
     * 包名
     */
    @SerializedName("packageName") val packageName: String,

    /**
     * app特殊权限项
     */
    @SerializedName("specialPermissionList") val specialPermissionList: List<String> = listOf(),

    /**
     * 更新时间
     */
    @SerializedName("lastTime") val updatedAt: Long? = null,

    /**
     * 版本名称，1.0.1
     */
    @SerializedName("versionCode") val version: String,

    /**
     * 版本好，1
     */
    @SerializedName("code") val versionCode: Int?
)
