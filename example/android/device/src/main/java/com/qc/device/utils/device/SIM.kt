package com.qc.device.utils.device

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import android.telecom.TelecomManager
import com.qc.device.model.Device
import com.qc.device.utils.DeviceUtil
import com.qc.device.utils.string

//TODO: SIM
fun DeviceUtil.getSIM():List<Device.Sim>{
//    val manager = activity.getSystemService(Context.TELEPHONY_SERVICE) as? TelecomManager

    val uri = Uri.parse("content://telephony/siminfo")
    val cursor = activity.contentResolver.query(
        uri,
        arrayOf("_id", "icc_id", "sim_id", "mcc", "mnc", "carrier_name", "number"),
       null,// "sim_id>=?",
        null,//arrayOf("0"),
        null as String?
    ) ?: return emptyList()
    val list = mutableListOf<Device.Sim>()
    while (cursor.moveToNext()) {
        list.add(Device.Sim(
            carrierName = cursor.string("carrier_name"),
            iccid = cursor.string("icc_id"),
            mcc = cursor.string("mcc"),
            mnc = cursor.string("mnc"),

        ))
    }
    cursor.close()
    return emptyList()
}