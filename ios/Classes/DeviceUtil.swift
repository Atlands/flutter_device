//
//  DeviceUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import AdSupport

class DeviceUtil {
    let uiDevice = UIDevice.current
    let processInfo = ProcessInfo.processInfo
    
    func getDevice() -> Device {
        return Device(
            batter: getBatter(),
            cpu: getCPU(),
            createdAt: Int(Date().timeIntervalSince1970) * 1000,
            device: getDeviceInfo(),
            isTable: UIDevice.current.userInterfaceIdiom == .pad,
            locale: getLocale(),
            network: getNetwork(),
            regDevice: 3,
//            regWifi: <#T##WifiInfo#>,
            screen: getScreen(),
            space: getSpace()
        )
    }
    
    func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    
    func getReferrer() -> String {
        let urlToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let installDate = try? FileManager.default.attributesOfItem(atPath: urlToDocumentsFolder.path)[FileAttributeKey.creationDate] as? Date
        let map = ["referrer": "utm_source=appstore&utm_medium=ios", "download_time": dateFormat.string(from: installDate ?? Date())]
        
        return dictToJson(dict: map) ?? "{}"
    }
    
    func getPackage() -> String {
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        let packageName = Bundle.main.bundleIdentifier ?? ""
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        
//        return PackInfo(name: appName, packageName: packageName, versionCode: version)
        let map = [
            "appName": appName,
            "packageName": packageName,
            "version": version
        ]
        
        return dictToJson(dict: map) ?? "{}"
    }
}
