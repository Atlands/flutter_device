//
//  DeviceInfo.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation
import AdSupport
import AVFoundation

extension DeviceUtil {
    func getDeviceInfo() -> DeviceInfo {
        return DeviceInfo(
            androidId: getDeviceId(),
            brand: "Apple",
            gaid: ASIdentifierManager.shared().advertisingIdentifier.uuidString,
            isRooted: isJailbroken(),
            isSimulator: isSimulator(),
            model: getModelName(),
            name: UIDevice.current.name,
            version: UIDevice.current.systemVersion
        )
    }
    
//    private func getRingerMode() -> Int {
//        // 获取当前的响铃类型
//        let ringerMode = AVAudioSession.sharedInstance().currentRoute.outputs.first?.portType
//
//        // 判断响铃类型
//        switch ringerMode {
//        case .builtInSpeaker?:
//            print("铃音模式")
//        case .builtInReceiver?:
//            return 0
//        case .virtual:
//            print("耳机模式")
//        default:
//            print("其他模式")
//        }
//    }

    
    private func getModelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    private func isSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
   private func isJailbroken() -> Bool {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
            fileManager.fileExists(atPath: "/Applications/FakeCarrier.app") ||
            fileManager.fileExists(atPath: "/Applications/Icy.app") ||
            fileManager.fileExists(atPath: "/Applications/IntelliScreen.app") ||
            fileManager.fileExists(atPath: "/Applications/SBSettings.app") {
            return true
        }
        return false
    }
}
