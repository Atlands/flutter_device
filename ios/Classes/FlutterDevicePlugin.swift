import Flutter
import UIKit

public class FlutterDevicePlugin: NSObject, FlutterPlugin {
    let mead = Deeml()
    let cmpk = CMPK()
    let csele = CSele()
    let mels = MELS()
//    let photoUtil = PhotoUtil()
    let cal = CAll()
//    let calendarUtil = CalendarUtil()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let cel = FlutterMethodChannel(name: "flutter_device", binaryMessenger: registrar.messenger())
        let deml = FlutterDevicePlugin()
        registrar.addMethodCallDelegate(deml, channel: cel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        switch call.method {
        case "device_id":
            let id = mead.id()
            result(id)
        case "install_referrer":
            result(mead.reffer())
        case "device_info":
            let data = mlea(from: mead.damldw())
            result(data)
        case "camera_picker":
            let option = call.arguments as? [String: Any?] ?? [:]
            cmpk.selecter(option: FJDAL(wamld: option["maxWidth"] as? Double, haldcl: option["maxHeight"] as? Double, qualmd: option["imageQuality"] as! CGFloat, fnoda: option["front"] as! Bool)) { res in
                if(res.code == ResultError.resultOK){
                    result(res.data)
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
        case "contact_picker":
            csele.selecter{ res in
                if res.code == ResultError.resultOK {
                    result(res.data)
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
            
        case "package_info":
            result(mead.myAp())
        case "position":
            mels.select{ res in
                if res.code == ResultError.resultOK {
                    result(res.data)
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
//        case "app_list":
//            result("[]")
//        case "sms_list":
//            result("[]")
//        case "call_log_list":
//            result("[]")
//        case "photo_list":
//            photoUtil.getPhotos{ res in
//                if res.code == ResultError.resultOK {
//                    result(getJsonString(from: res.data))
//                }else {
//                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
//                }
//            }
        case "contact_list":
            cal.findAll{ res in
                if res.code == ResultError.resultOK {
                    result(mlea(from: res.data))
                } else {
                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
                }
            }
//        case "calendar_list":
//            calendarUtil.getContacts { res in
//                if res.code == ResultError.resultOK {
//                    result(getJsonString(from: res.data))
//                } else {
//                    result(FlutterError(code: "\(res.code)", message: res.message, details: nil))
//                }
//            }
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
