package com.qc.device.utils

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import kotlin.Exception

val dateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).apply {
    isLenient = false
}

fun Date.formatDate(): String  = try{
    dateFormat.format(this)
}catch (_:Exception){
    ""
}

fun Long.formatDate(): String = try {
    val date = Date(this)
    dateFormat.format(date)
} catch (_: Exception) {
    ""
}