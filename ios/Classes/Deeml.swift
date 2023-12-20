//
//  DeviceUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import AdSupport

class Deeml {
    let mlad = UIDevice.current
    let amlde = ProcessInfo.processInfo
    
    func damldw() -> ODEE {
        return ODEE(
            batter: getBatter(),
            cpu: getCPU(),
            createdAt: Int(Date().timeIntervalSince1970) * 1000,
            device: getDeviceInfo(),
            isTable: UIDevice.current.userInterfaceIdiom == .pad,
            locale: getLocale(),
            network: getNetwork(),
            regDevice: 3,
//            regWifi: T##WifiInfo,
            screen: getScreen(),
            space: getSpace()
        )
    }
    
    func id() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    
    func reffer() -> String {
        let ead = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let daea = try? FileManager.default.attributesOfItem(atPath: ead.path)[FileAttributeKey.creationDate] as? Date
        let map = ["referrer": "utm_source=appstore&utm_medium=ios", "download_time": format.string(from: daea ?? Date())]
        
        return vdaea(dict: map) ?? "{}"
    }
    
    func myAp() -> String {
        let adfml = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        let dfmka = Bundle.main.bundleIdentifier ?? ""
        let mvae = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        
//        return PackInfo(name: appName, packageName: packageName, versionCode: version)
        let ada = [
            "appName": adfml,
            "packageName": dfmka,
            "version": mvae
        ]
        
        return vdaea(dict: ada) ?? "{}"
    }
}
