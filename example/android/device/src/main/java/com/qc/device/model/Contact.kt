package com.qc.device.model

import com.google.gson.annotations.SerializedName

data class Contact(
    @SerializedName("id") override val id: String = "",
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
    @SerializedName("displayName")  val displayName: String,

    /**
     * 邮箱
     */
    @SerializedName("email")  val email: String = "",

    /**
     * 姓，家庭名称
     */
    @SerializedName("familyName")   val familyName: String = "",

    /**
     * 名，主要名字
     */
    @SerializedName("giveName")     val giveName: String = "",

    /**
     * 手机号
     */
    @SerializedName("phone")   val phone: String,

    /**
     * 是否收藏
     */
    @SerializedName("starred")   val starred: Boolean = false,

    /**
     * 更新时间
     */
    @SerializedName("updatedAt")   override val updatedAt: Long = 0,
    @SerializedName("createdAt")    override val createdAt: Long = 0,
) : DataID, DataDate

