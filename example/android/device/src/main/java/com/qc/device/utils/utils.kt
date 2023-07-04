package com.qc.device.utils

import android.database.Cursor
import kotlin.Exception

fun Cursor.string(value: String) = try {
    getString(getColumnIndexOrThrow(value)) ?: ""
} catch (e: Exception) {
    e.printStackTrace()
    ""
}

fun Cursor.long(value: String) = try {
    getLong(getColumnIndexOrThrow(value))
} catch (e: Exception) {
    e.printStackTrace()
    0
}

fun Cursor.int(value: String) = try {
    getInt(getColumnIndexOrThrow(value))
}catch (e: Exception){
    e.printStackTrace()
    0
}

fun Cursor.double(value: String) = try {
    getDouble(getColumnIndexOrThrow(value))
}catch (e: Exception){
    e.printStackTrace()
    0.0
}