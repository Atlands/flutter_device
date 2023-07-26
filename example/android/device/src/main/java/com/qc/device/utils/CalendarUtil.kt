package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import android.provider.CalendarContract
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Calendar
import com.qc.device.model.Result
import com.qc.device.model.ResultError

class CalendarUtil(val activity: ComponentActivity) {
    private val allCalendars = mutableListOf<Calendar>()
    private var startId = 0L
    private var onResult: ((Result<List<Calendar>>) -> Unit)? = null
    private val permission = activity.registerForActivityResult(ActivityResultContracts.RequestPermission()){
        if (it){
            onResult?.invoke(Result(ResultError.RESULT_OK,null,allCalendars()))
        }else{
            onResult?.invoke(Result(ResultError.CALENDAR_PERMISSION,"calendar permission denied",allCalendars))
        }
        onResult = null
    }

    fun getCalendars(id:Long,onResult: (Result<List<Calendar>>) -> Unit){
        this.startId = id
        this.onResult = onResult
        val key = Manifest.permission.READ_CALENDAR
        if (ContextCompat.checkSelfPermission(activity,key) == PackageManager.PERMISSION_GRANTED){
            this.onResult?.invoke(Result(ResultError.RESULT_OK,null,allCalendars()))
            this.onResult = null
        }else{
            permission.launch(key)
        }
    }


    private fun allCalendars():List<Calendar>{
        if (allCalendars.isNotEmpty()) return allCalendars
        val cursor =
            activity.contentResolver.query(
                CalendarContract.Events.CONTENT_URI,
                null,
                "${CalendarContract.Events.CALENDAR_ID} > $startId",
                null,
                "${CalendarContract.Events._ID} ASC"
            ) ?: return allCalendars
        while (cursor.moveToNext()){
            allCalendars.add(
                Calendar(
                    id = cursor.long(CalendarContract.Events._ID),
                    eventTitle = cursor.string(CalendarContract.Events.TITLE),
                    description = cursor.string(CalendarContract.Events.DESCRIPTION),
                    startTime = cursor.long(CalendarContract.Events.DTSTART).formatDate(),
                    endTime = cursor.long(CalendarContract.Events.DTEND).formatDate()
                )
            )
        }
        cursor.close()
        return allCalendars
    }
}