package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Contact(
//    @SerializedName("id") val id: String = "",
    /**
     * 联系次数
     */
    @SerializedName("contactedTimes")  val contactedTimes: Long = 0,

    /**
     * 最后联系时间
     */
    @SerializedName("contactedUpdateAt")  val contactedUpdateAt: Long = 0,

    /**
     * 联系人显示名称
     */
    @SerializedName("other_name")  val displayName: String,

    /**
     * 邮箱
     */
    @SerializedName("email")  val email: String = "",

    /**
     * 姓，家庭名称
     */
    @SerializedName("lastName")   val familyName: String = "",

    /**
     * 名，主要名字
     */
    @SerializedName("firstName")     val giveName: String = "",

    /**
     * 手机号
     */
    @SerializedName("other_mobile")   val phone: String,

    /**
     * 是否收藏
     */
    @SerializedName("starred")   val starred: Boolean = false,

    /**
     * 更新时间
     */
    @SerializedName("last_time")   val updatedAt: String,
)

