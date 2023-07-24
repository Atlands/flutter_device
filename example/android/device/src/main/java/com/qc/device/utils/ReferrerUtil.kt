package com.qc.device.utils

import android.content.Context
import android.os.RemoteException
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
import com.qc.device.model.Referrer
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.withTimeout
import java.util.Calendar
import java.util.Date

object ReferrerUtil {


    /**
     * 安装信息
     */
    suspend fun getReferrerDetails(context: Context): Referrer {
        val deferredReferrerDetails = CompletableDeferred<ReferrerDetails?>()
        val client = InstallReferrerClient.newBuilder(context.applicationContext).build()
        client.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseInt: Int) {
                if (responseInt == InstallReferrerClient.InstallReferrerResponse.OK) {
                    deferredReferrerDetails.complete(
                        try {
                            client.installReferrer
                        } catch (e: RemoteException) {
                            null
                        }
                    )
                } else {
                    deferredReferrerDetails.complete(null)
                }
                client.endConnection()
            }

            override fun onInstallReferrerServiceDisconnected() {
                if (!deferredReferrerDetails.isCompleted) {
                    deferredReferrerDetails.complete(null)
                }
            }
        })

        val detail = withTimeout(1000) { deferredReferrerDetails.await() }

        return Referrer(
            referrer = detail?.installReferrer ?: "unknown",
            installDate = detail?.installBeginTimestampSeconds?.let { seconds ->
                Calendar.getInstance()
                    .apply { add(Calendar.SECOND, -seconds.toInt()) }.time.formatDate()
            } ?: Date().formatDate(),
        )
    }
}