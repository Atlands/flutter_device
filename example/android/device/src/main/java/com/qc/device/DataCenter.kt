package com.qc.device

import android.content.Context
import android.content.SharedPreferences
import androidx.activity.ComponentActivity
import com.qc.device.model.App
import com.qc.device.model.Contact
import com.qc.device.model.DataDate
import com.qc.device.model.DataID
import com.qc.device.model.Result
import com.qc.device.model.ResultError
import com.qc.device.utils.ContactUtil
import com.qc.device.utils.PackageUtil

object PreferencesKey {
    const val Contact_IDS = "contact_ids"
}

class DataCenter(activity: ComponentActivity) {
    private val contactUtil: ContactUtil = ContactUtil(activity)
    private val packageUtil = PackageUtil(activity)
    private val preferences: SharedPreferences =
        activity.getSharedPreferences("DeviceData", Context.MODE_PRIVATE)

    fun getContacts(onResult: (Result<List<Contact>>) -> Unit) {
        contactUtil.getContacts {
            if (it.code == ResultError.RESULT_OK) {
                val data = deduplicationByID(it.data, PreferencesKey.Contact_IDS)
                onResult(it.copy(data = data))
            } else {
                onResult(it)
            }
        }
    }

    ///通过id进行增量去重
    private fun <T : DataID> deduplicationByID(allData: List<T>, preferencesKey: String): List<T> {
        val oldIds = preferences.getStringSet(preferencesKey, setOf()) ?: setOf()
        val newIds = allData.map { it.id }.toSet()
        return if (oldIds.isEmpty()) {
            allData
        } else {
            val difference = newIds - oldIds
            allData.filter { it.id in difference }
        }
    }

    //通过时间进行增量去重
    private fun <T : DataDate> deduplicationByDate(
        allData: List<T>,
        preferencesKey: String
    ): List<T> {
        val oldTimestamp = preferences.getLong(preferencesKey, 0)
        return allData.filter {
            it.createdAt > oldTimestamp
        }
    }

    fun getPackageInfo(): App = packageUtil.getPackageInfo()
}