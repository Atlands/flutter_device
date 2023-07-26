package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Telephony
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Contact
import com.qc.device.model.Message
import com.qc.device.model.Result
import com.qc.device.model.ResultError

class MessageUtil(val activity: ComponentActivity) {
    private val allMessages = mutableListOf<Message>()
    private var startTimestamp = 0L
    private val nameMap = mutableMapOf<String, String>()
    private var onResult: ((Result<List<Message>>) -> Unit)? = null

    private val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, allMessages()))
            } else {
                onResult?.invoke(
                    Result(
                        ResultError.MESSAGE_PERMISSION, "sms permission denied",
                        emptyList()
                    )
                )
            }
            onResult = null
        }

    fun getMessages(
        startTimestamp: Long,
        contacts: List<Contact>,
        onResult: (Result<List<Message>>) -> Unit
    ) {
        this.startTimestamp = startTimestamp
        this.onResult = onResult
        contacts.forEach{
            this.nameMap[it.phone] = it.displayName
        }
        val key = Manifest.permission.READ_SMS
        if (ContextCompat.checkSelfPermission(
                activity,
                key
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            this.onResult?.invoke(Result(ResultError.RESULT_OK, null, allMessages()))
            this.onResult = null

        } else {
            permission.launch(key)
        }
    }

    private fun allMessages(): List<Message> {
        if (allMessages.isNotEmpty()) return allMessages
        val properties = mutableListOf(
            Telephony.Sms._ID,
            Telephony.Sms.ADDRESS,
            Telephony.Sms.PERSON,
            Telephony.Sms.BODY,
            Telephony.Sms.DATE,
            Telephony.Sms.TYPE,
            Telephony.Sms.READ,
        )

        val cursor = activity.contentResolver.query(
            Uri.parse("content://sms/"),
            properties.toTypedArray(),
            "${Telephony.Sms.DATE} > $startTimestamp",
            null,
            "date desc"
        ) ?: return allMessages

        while (cursor.moveToNext()){
            val phone = cursor.string(Telephony.Sms.ADDRESS)
            allMessages.add(
                Message(
                    name = (nameMap[phone] ?: "").ifBlank { phone },
                    phone = phone,
                    content = cursor.string(Telephony.Sms.BODY),
                    time = cursor.long(Telephony.Sms.DATE).formatDate(),
                    type = cursor.int(Telephony.Sms.TYPE),
                    read = cursor.int(Telephony.Sms.READ),
                )
            )
        }
        cursor.close()
        return allMessages
    }
}