package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import android.provider.ContactsContract
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Contact
import com.qc.device.model.ResultError
import com.qc.device.model.Result

class ContactUtil(private val activity: ComponentActivity) {
    private var onResult: ((Result<List<Contact>>) -> Unit)? = null
    private var allContacts = mutableListOf<Contact>()

    private val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, allContacts()))
            } else {
                onResult?.invoke(
                    Result(
                        ResultError.CONTACT_PERMISSION,
                        "contact permission denied",
                        emptyList()
                    )
                )
            }
            onResult = null
        }

    fun getContacts(onResult: (Result<List<Contact>>) -> Unit) {
        this.onResult = onResult
        if (ContextCompat.checkSelfPermission(
                activity,
                Manifest.permission.READ_CONTACTS
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            this.onResult?.invoke(Result(ResultError.RESULT_OK, null, allContacts()))
            this.onResult = null
        } else {
            permission.launch(Manifest.permission.READ_CONTACTS)
        }
    }

    private fun allContacts(): List<Contact> {
        if (allContacts.isNotEmpty()) return allContacts
        val cursor =
            activity.contentResolver.query(
                ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                null,
                null,
                null,
                null
            ) ?: return allContacts

        while (cursor.moveToNext()) {
            val contact = Contact(
//                id = cursor.string(ContactsContract.CommonDataKinds.Phone.CONTACT_ID),
                displayName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME),
                familyName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME_SOURCE),
                giveName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME_PRIMARY),
                phone = cursor.string(ContactsContract.CommonDataKinds.Phone.NUMBER),
                updatedAt = cursor.long(ContactsContract.CommonDataKinds.Phone.CONTACT_LAST_UPDATED_TIMESTAMP).formatDate()
            )
            allContacts.add(contact)
        }
        cursor.close()
        return allContacts
    }
}