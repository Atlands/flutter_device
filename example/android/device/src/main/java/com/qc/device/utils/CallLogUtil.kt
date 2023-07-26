package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import android.database.Cursor
import android.provider.CallLog
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Result
import com.qc.device.model.ResultError
import com.qc.device.utils.device.CallLogInfo

class CallLogUtil(val activity: ComponentActivity) {
    private val allCallLogs = mutableListOf<CallLogInfo>()
    private var timestamp = 0L
    private var onResult: ((Result<List<CallLogInfo>>) -> Unit)? = null

    val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, allCallLogs()))
            } else {
                onResult?.invoke(
                    Result(
                        ResultError.CALL_LOG_PERMISSION,
                        "call log permission denied",
                        allCallLogs
                    )
                )
            }
            onResult = null
        }

    fun getCallLogs(timestamp: Long, onResult: (Result<List<CallLogInfo>>) -> Unit) {
        this.onResult = onResult
        this.timestamp = timestamp
        val key = Manifest.permission.READ_CALL_LOG
        if (ContextCompat.checkSelfPermission(activity, key) == PackageManager.PERMISSION_GRANTED) {
            this.onResult?.invoke(Result(ResultError.RESULT_OK, null, allCallLogs()))
            this.onResult = null
        } else {
            permission.launch(key)
        }
    }


    private fun allCallLogs(): List<CallLogInfo> {
        if (allCallLogs.isNotEmpty()) return allCallLogs

        val columns = arrayOf(
            CallLog.Calls.CACHED_NAME // 通话记录的联系人
            , CallLog.Calls.NUMBER // 通话记录的电话号码
            , CallLog.Calls.DATE // 通话记录的日期
            , CallLog.Calls.DURATION // 通话时长
            , CallLog.Calls.TYPE
        ) // 通话类型}
        val cursor: Cursor = activity.contentResolver.query(
            CallLog.Calls.CONTENT_URI,  // 查询通话记录的URI
            columns,
            "${CallLog.Calls.DATE} > $timestamp",
            null,
            CallLog.Calls.DEFAULT_SORT_ORDER // 按照时间逆序排列，最近打的最先显示
        ) ?: return allCallLogs
        while (cursor.moveToNext()) {
            allCallLogs.add(
                CallLogInfo(
                    name = cursor.string(CallLog.Calls.CACHED_NAME),
                    phone = cursor.string(CallLog.Calls.NUMBER),
                    creartedAt = cursor.long(CallLog.Calls.DATE).formatDate(),
                    duration = cursor.int(CallLog.Calls.DURATION),
                    type = cursor.int(CallLog.Calls.TYPE),
                )
            )
        }
        cursor.close()
        return allCallLogs
    }
}