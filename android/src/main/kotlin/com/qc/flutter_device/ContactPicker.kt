package com.qc.flutter_device

import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import com.qc.device.model.Contact
import com.qc.device.model.Result
import com.qc.device.utils.string

class ContactPicker(private val activity: ComponentActivity) {
    private val contactIntent =
        activity.registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { activityResult ->
            activityResult?.data?.data?.let {
                val contact = uriToContact(it)
                result?.let { res ->
                    res(Result(code = 200, data = contact))
                }
            }
            result = null
        }

    private var result: ((Result<Contact?>) -> Unit)? = null

    fun picker(result: (Result<Contact?>) -> Unit) {
        this.result = result
        val intent = Intent(Intent.ACTION_PICK)
        intent.type = ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE
        contactIntent.launch(intent)
    }

    private fun uriToContact(uri: Uri): Contact? {
        val cursor = activity.contentResolver.query(
            uri,
            arrayOf(
                ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME,
                ContactsContract.CommonDataKinds.Phone.NUMBER,
            ),
            null,
            null,
            null
        ) ?: return null
        var contact: Contact? = null
        while (cursor.moveToNext()) {
            contact = Contact(
                displayName = cursor.string(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME),
                phone = cursor.string(ContactsContract.CommonDataKinds.Phone.NUMBER),
            )
        }
        cursor.close()
        return contact
    }
}