package com.qc.device.utils

import android.Manifest
import android.content.pm.PackageManager
import android.provider.ContactsContract
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Contact

class ContactUtil(private val activity: ComponentActivity) {
    private var result: (Task<List<Contact>>)? = null
    private var allContacts = mutableListOf<Contact>()

    private val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestPermission()) {
            if (it) {
                result?.invoke(allContacts(), null)
            } else {
                result?.invoke(
                    null,
                    ResultError(ResultError.Permission_Contact, "contact permission denied")
                )
            }
        }

    fun getContacts(task: Task<List<Contact>>) {
        this.result = task
        if (ContextCompat.checkSelfPermission(
                activity,
                Manifest.permission.READ_CONTACTS
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            result?.invoke(allContacts(), null)
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
            ) ?: return listOf()
        allContacts.clear()
        while (cursor.moveToNext()) {
            val contact = Contact(
                id = cursor.string(ContactsContract.CommonDataKinds.Phone.CONTACT_ID),
                displayName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME),
                familyName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME_SOURCE),
                giveName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME_PRIMARY),
                phone = cursor.string(ContactsContract.CommonDataKinds.Phone.NUMBER),
                updatedAt = cursor.long(ContactsContract.CommonDataKinds.Phone.CONTACT_LAST_UPDATED_TIMESTAMP)
            )
            allContacts.add(contact)
        }
        cursor.close()
        return allContacts
    }
}

typealias Task<T> = (T?, ResultError?) -> Unit

data class ResultError(
    val code: Int,
    val message: String,
) {
    companion object {
        const val Permission_Contact = 100001
    }
}