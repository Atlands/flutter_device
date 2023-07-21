package com.qc.flutter_device

import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.qc.device.DataCenter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

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
            "contact_picker" -> {
                contactPicker.picker {
                    result.success(GSON.toJson(it.data))
                }
            }

            "camera_picker" -> {
                val font = call.arguments as? Boolean ?: false
                cameraPicker.picker(font) {
                    if (it.code == 200) {
                        result.success(GSON.toJson(it.data))
                    } else {
                        result.error(it.code.toString(), it.message, null)
                    }
                }
            }

//            "get_package_info" -> {
//                try {
//                    val info = PackageInfo.getPackageInfo(activity)
//                    result.success(GSON.toJson(info))
//                } catch (e: Exception) {
//                    result.error("1001", e.message ?: "", null)
//                }
//            }

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
