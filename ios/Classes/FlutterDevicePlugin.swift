import Flutter
import UIKit

public class FlutterDevicePlugin: NSObject, FlutterPlugin {
    let deviceUtil = DeviceUtil()
    let cameraPicker = CameraPicker()
    let contactPicker = ContactPicker()
    let positionUtil = PositionUtil()
    let photoUtil = PhotoUtil()
    let contactUtil = ContactUtil()
    let calendarUtil = CalendarUtil()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_device", binaryMessenger: registrar.messenger())
        let instance = FlutterDevicePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        switch call.method {
        case "device_id":
            let id = deviceUtil.getDeviceId()
            result(id)
        case "install_referrer":
            result(deviceUtil.getReferrer())
        case "device_info":
            let data = getJsonString(from: deviceUtil.getDevice())
            result(data)
        case "camera_picker":
            let option = call.arguments as? [String: Any?] ?? [:]
            cameraPicker.picker(option: ImageOption(maxWidth: option["maxWidth"] as? Double, maxHeight: option["maxHeight"] as? Double, imageQuality: option["imageQuality"] as! CGFloat, front: option["front"] as! Bool)) { res in
                if(res.code == ResultError.resultOK){
                    result(res.data)
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "contact_picker":
            contactPicker.picker{ res in
                result(res.data)
            }
        case "package_info":
            result(deviceUtil.getPackage())
        case "position":
            positionUtil.picker{ res in
                if res.code == ResultError.resultOK {
                    result(res.data)
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "app_list":
            result("[]")
        case "sms_list":
            result("[]")
        case "call_log_list":
            result("[]")
        case "photo_list":
            photoUtil.getPhotos{ res in
                if res.code == ResultError.resultOK {
                    result(getJsonString(from: res.data))
                }else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "contact_list":
            contactUtil.getContacts{ res in
                if res.code == ResultError.resultOK {
                    result(getJsonString(from: res.data))
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "calendar_list":
            calendarUtil.getContacts { res in
                if res.code == ResultError.resultOK {
                    result(getJsonString(from: res.data))
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "clean_preferences":
//            let defaults = UserDefaults.standard
//            defaults.removeObject(forKey: "app_timestamp")
            result(true)
        case "save_preferences":
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
