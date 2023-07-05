package com.qc.device

import android.content.Context
import android.content.SharedPreferences
import androidx.activity.ComponentActivity
import com.qc.device.model.Contact
import com.qc.device.model.DataDate
import com.qc.device.model.DataID
import com.qc.device.utils.ContactUtil
import com.qc.device.utils.Task

object PreferencesKey {
    const val Contact_IDS = "contact_ids"
}

class DataCenter(activity: ComponentActivity) {
    private val contactUtil: ContactUtil = ContactUtil(activity)
    private val preferences: SharedPreferences =
        activity.getSharedPreferences("DeviceData", Context.MODE_PRIVATE)

    fun getContacts(result: Task<List<Contact>>) {
        contactUtil.getContacts { contacts, error ->
            if (error == null) {
                val data = deduplicationByID(contacts!!, PreferencesKey.Contact_IDS)
                result(data, null)
            } else {
                result(null, error)
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
}