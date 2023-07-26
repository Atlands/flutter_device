package com.qc.device.utils

import androidx.activity.ComponentActivity
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.qc.device.model.Referrer
import java.util.Calendar
import java.util.Date
import com.qc.device.model.Result
import com.qc.device.model.ResultError

class ReferrerUtil(val activity: ComponentActivity) {

    /**
     * 安装信息
     */
    fun getReferrerDetails(onResult: (Result<Referrer?>) -> Unit) {
        val client = InstallReferrerClient.newBuilder(activity).build()
        client.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseInt: Int) {
                if (responseInt == InstallReferrerClient.InstallReferrerResponse.OK) {
                    val referrer = Referrer(
                        referrer = client.installReferrer?.installReferrer ?: "unknown",
                        installDate = client.installReferrer?.installBeginTimestampSeconds?.let { seconds ->
                            Calendar.getInstance()
                                .apply { add(Calendar.SECOND, -seconds.toInt()) }.time.formatDate()
                        } ?: Date().formatDate(),
                    )
                    onResult(Result(ResultError.RESULT_OK, null, referrer))
                } else {
                    onResult(Result(ResultError.REFERRER_ERROR,"connect referrer server failed",null))
                }
                client.endConnection()
            }

            override fun onInstallReferrerServiceDisconnected() {
                onResult(Result(ResultError.REFERRER_ERROR,"connect referrer server failed",null))
            }
        })
    }
}