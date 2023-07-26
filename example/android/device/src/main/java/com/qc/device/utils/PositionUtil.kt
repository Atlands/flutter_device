package com.qc.device.utils

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.location.Geocoder
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.qc.device.model.Position
import com.qc.device.model.ResultError
import java.lang.Exception
import java.util.Date
import com.qc.device.model.Result

class PositionUtil(val activity: ComponentActivity) {
    private var position: Position? = null
    private var onResult: ((Result<Position?>) -> Unit)? = null
    private val permission =
        activity.registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) {
            if (it[Manifest.permission.ACCESS_COARSE_LOCATION] == true) {
                onResult?.invoke(Result(ResultError.RESULT_OK, null, position()))
            } else {
                onResult?.invoke(Result(ResultError.LOCATION_PERMISSION, null, position))
            }
            onResult = null
        }

    fun getPosition(onResult: (Result<Position?>) -> Unit) {
        this.onResult = onResult
        if (ContextCompat.checkSelfPermission(
                activity,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            this.onResult?.invoke(Result(ResultError.RESULT_OK, null, position()))
            this.onResult = null
        } else {
            val keys = arrayOf(
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
            )
            permission.launch(keys)
        }
    }

    @SuppressLint("MissingPermission")
    private fun position(): Position? {
        if (position != null) return position
        val manager =
            activity.getSystemService(Context.LOCATION_SERVICE) as? LocationManager ?: return null
        if (!manager.isProviderEnabled(LocationManager.GPS_PROVIDER)) return null
        ///gps
        try {
            if (ContextCompat.checkSelfPermission(
                    activity,
                    Manifest.permission.ACCESS_FINE_LOCATION
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                val location = manager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                if (location != null) {
                    position = decode(location.latitude, location.longitude)
                    return position
                }
                manager.requestLocationUpdates(
                    LocationManager.GPS_PROVIDER,
                    0,
                    0F,
                    locationListener
                )
            }
        } catch (_: Exception) {
        }
        //network
        try {
            if (ContextCompat.checkSelfPermission(
                    activity,
                    Manifest.permission.ACCESS_COARSE_LOCATION
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                val location = manager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
                if (location != null) {
                    position = decode(location.latitude, location.longitude)
                    return position
                }
                manager.requestLocationUpdates(
                    LocationManager.NETWORK_PROVIDER,
                    0,
                    0F,
                    locationListener
                )
            }
        } catch (_: Exception) {
        }
        return null
    }

    private fun decode(latitude: Double, longitude: Double): Position {
        val position = Position(latitude = latitude, longitude = longitude)
        try {
            val geocoder = Geocoder(activity)
            val addresses = geocoder.getFromLocation(latitude, longitude, 1)
            if (!addresses.isNullOrEmpty()) {
                val gLocation = addresses.first()
                position.apply {
                    address = gLocation.getAddressLine(0) ?: ""
                    geo_time = Date().formatDate()
                    gps_address_province = gLocation.adminArea
                    gps_address_city = gLocation.locality
                    gps_address_street = gLocation.subLocality
                }
            }
        } catch (_: Exception) {
        }
        return position
    }

    private val locationListener = LocationListener {
        try {
            position = decode(it.latitude, it.longitude)
        } catch (_: Exception) {
        }
    }
}