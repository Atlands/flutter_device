package com.qc.flutter_device

import androidx.activity.ComponentActivity
import androidx.lifecycle.lifecycleScope
import com.google.gson.Gson
import com.qc.device.DataCenter
import com.qc.device.model.ResultError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.launch

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

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_device")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

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
                val arg = call.arguments as Map<*, *>
                val imageOption = ImageOption(
                    maxWidth = arg["maxWidth"] as Double?,
                    maxHeight = arg["maxHeight"] as Double?,
                    imageQuality = arg["imageQuality"] as Int? ?: 100,
                    front = arg["front"] as? Boolean ?: false,
                )
                cameraPicker.picker(imageOption) {
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
                activity.lifecycleScope.launch { result.success(GSON.toJson(dataCenter.getApps())) }
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

            "call_logs_list" -> {
                dataCenter.getCallLogs {
                    if (it.code == ResultError.RESULT_OK) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

            "save_preferences" -> {
                @Suppress("UNCHECKED_CAST")
                dataCenter.savePreferences(call.arguments as Map<String, Any>)
                result.success(true)
            }

            "clean_preferences" -> {
                dataCenter.cleanPreferences()
                result.success(true)
            }


            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
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
