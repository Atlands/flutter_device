package com.qc.flutter_device

import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.google.gson.JsonObject
import com.qc.device.DataCenter
import com.qc.device.model.ResultError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

/** FlutterDevicePlugin */
class FlutterDevicePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var activity: ComponentActivity
    private lateinit var channel: MethodChannel
    private lateinit var contactPicker: ContactPicker
    private lateinit var cameraPicker: CameraPicker
    private lateinit var dataCenter: DataCenter

    private var GSON = Gson()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_device")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "device_id" -> {
                val id = dataCenter.getDeviceId()
                result.success(id)
            }

            "install_referrer" -> {
                dataCenter.getReferrer {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "contact_picker" -> {
                contactPicker.picker {
                    result.success(GSON.toJson(it.data))
                }
            }

            "camera_picker" -> {
                val font = call.arguments as? Boolean ?: false
                cameraPicker.picker(font) {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(it.data)
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "package_info" -> {
                try {
                    val info = dataCenter.getPackageInfo()
                    result.success(GSON.toJson(info))
                } catch (e: Exception) {
                    result.error(ResultError.PACKAGE_EXCEPTION.toString(), e.message ?: "", null)
                }
            }

            "device_info" -> {
                dataCenter.getDevice {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "position" -> {
                dataCenter.getPosition {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "app_list" -> {
                result.success(GSON.toJson(dataCenter.getApps()))
            }

            "photo_list" -> {
                dataCenter.getPhotos {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "sms_list" -> {
                dataCenter.getMessages {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "contact_list" -> {
                dataCenter.getContacts {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }

                }
            }

            "calendar_list" -> {
                dataCenter.getCalendars {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "call_log_list" -> {
                dataCenter.getCallLogs {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "save_preferences" -> {
//                val map =
//                    Gson().fromJson<Map<String, Any>>(call.arguments as String, Map::class.java)
                @Suppress("UNCHECKED_CAST")
                dataCenter.savePreferences(call.arguments as Map<String, Any>)
                result.success(true)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as ComponentActivity
        contactPicker = ContactPicker(activity)
        cameraPicker = CameraPicker(activity)
        dataCenter = DataCenter(activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}
