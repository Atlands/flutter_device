package com.qc.device

import android.content.Context
import android.content.SharedPreferences
import androidx.activity.ComponentActivity
import androidx.core.content.edit
import com.qc.device.model.App
import com.qc.device.model.Calendar
import com.qc.device.model.Contact
import com.qc.device.model.Device
import com.qc.device.model.Message
import com.qc.device.model.Photo
import com.qc.device.model.Position
import com.qc.device.model.Result
import com.qc.device.model.ResultError
import com.qc.device.utils.CalendarUtil
import com.qc.device.utils.CallLogUtil
import com.qc.device.utils.ContactUtil
import com.qc.device.utils.DeviceUtil
import com.qc.device.utils.MessageUtil
import com.qc.device.utils.PackageUtil
import com.qc.device.utils.PhotoUtil
import com.qc.device.utils.PositionUtil
import com.qc.device.utils.dateFormat
import com.qc.device.utils.device.CallLogInfo
import java.util.UUID

object PreferencesKey {
    const val device_ID = "device_id"
    const val Contact_IDS = "contact_ids"
}

class DataCenter(activity: ComponentActivity) {
    private val contactUtil: ContactUtil = ContactUtil(activity)
    private val packageUtil = PackageUtil(activity)
    private val deviceUtil = DeviceUtil(activity)
    private val calendarUtil = CalendarUtil(activity)
    private val messageUtil = MessageUtil(activity)
    private val photoUtil = PhotoUtil(activity)
    private val positionUtil = PositionUtil(activity)
    private val callLogUtil = CallLogUtil(activity)

    private val preferences: SharedPreferences =
        activity.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)

    fun getDevice(onResult: (Result<Device>) -> Unit) {
        deviceUtil.getDevice(onResult)
    }

    fun getContacts(onResult: (Result<List<Contact>>) -> Unit) {
        contactUtil.getContacts { result ->
            if (result.code == ResultError.RESULT_OK) {
                val timestamp = preferences.getLong("flutter.contact_timestamp", 0)
                val data = result.data.filter {
                    try {
                        (dateFormat.parse(it.updatedAt)?.time ?: 0) > timestamp
                    } catch (_: Exception) {
                        true
                    }
                }
                onResult(result.copy(data = data))
            } else {
                onResult(result)
            }
        }
    }

    fun getCalendars(onResult: (Result<List<Calendar>>) -> Unit) {
        val id = preferences.getLong("flutter.calendar_id", 0)
        calendarUtil.getCalendars(id, onResult)
    }

    fun getMessages(onResult: (Result<List<Message>>) -> Unit) {
        contactUtil.getContacts {
            val timestamp = preferences.getLong("flutter.sms_timestamp", 0)
            messageUtil.getMessages(timestamp, it.data, onResult)
        }
    }

    fun getApps() =
        packageUtil.allPackages()

    fun getPhotos(onResult: (Result<List<Photo>>) -> Unit) {
        val timestamp = preferences.getLong("flutter.photo_timestamp", 0)
        photoUtil.getPhotos(timestamp, onResult)
    }

    fun getCallLogs(onResult: (Result<List<CallLogInfo>>) -> Unit) {
        val timestamp = preferences.getLong("flutter.call_log_timestamp", 0)
        callLogUtil.getCallLogs(timestamp, onResult)
    }

    fun getPosition(onResult: (Result<Position?>) -> Unit) {
        positionUtil.getPosition(onResult)
    }


    ///通过id进行增量去重
//    private fun <T : DataID> deduplicationByID(allData: List<T>, preferencesKey: String): List<T> {
//        val oldIds = preferences.getStringSet(preferencesKey, setOf()) ?: setOf()
//        val newIds = allData.map { it.id }.toSet()
//        return if (oldIds.isEmpty()) {
//            allData
//        } else {
//            val difference = newIds - oldIds
//            allData.filter { it.id in difference }
//        }
//    }
//
//    //通过时间进行增量去重
//    private fun <T : DataDate> deduplicationByDate(
//        allData: List<T>,
//        preferencesKey: String
//    ): List<T> {
//        val oldTimestamp = preferences.getLong(preferencesKey, 0)
//        return allData.filter {
//            it.createdAt > oldTimestamp
//        }
//    }

    /**
     * 获取本包信息
     */
    fun getPackageInfo(): App = packageUtil.getPackageInfo()

    /**
     * 获取设备唯一标识符
     */
    fun getDeviceId(): String = deviceUtil.getAndroidID().ifBlank {
        var id = preferences.getString(PreferencesKey.device_ID, "") ?: ""
        if (id.isBlank()) {
            id = UUID.randomUUID().toString()
            preferences.edit {
                putString(PreferencesKey.device_ID, id)
            }
        }
        return@ifBlank id
    }
}