package com.qc.device.utils.device

import android.content.Context
import com.qc.device.model.Device
import java.util.Locale
import java.util.TimeZone

fun getLocale(): Device.Locale {
    val timeZone = TimeZone.getDefault()
    val locale = Locale.getDefault()
    return Device.Locale(
        timeZoneId = timeZone.id,
        timeZone = timeZone.getDisplayName(false, TimeZone.SHORT),
        ios3Country = locale.isO3Country,
        iso3Language = locale.isO3Language,
        displayCountry = locale.displayCountry,
        displayLanguage = locale.displayLanguage,
        displayName = locale.displayName,
        country = locale.country,
        language = locale.language,
    )
}