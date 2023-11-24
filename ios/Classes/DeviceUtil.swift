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
    
    func getDevice() -> [String: Any] {
        //        return Device(
        //            batter: getBatter(),
        //            cpu: getCPU(),
        //            createdAt: Int(Date().timeIntervalSince1970) * 1000,
        //            device: getDeviceInfo(),
        //            isTable: UIDevice.current.userInterfaceIdiom == .pad,
        //            locale: getLocale(),
        //            network: getNetwork(),
        //            regDevice: 3,
        ////            regWifi: T##WifiInfo,
        //            screen: getScreen(),
        //            space: getSpace()
        //        )
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowString = formatter.string(from: Date())
        let space = getSpace()
        let device = getDeviceInfo()
        let batter = getBatter()
        let cpu = getCPU()
        let screen = getScreen()
        
        let timeZone = TimeZone.current
        let secondsFromGMT = timeZone.secondsFromGMT()
        let hoursFromGMT = secondsFromGMT / 3600
        let minutesFromGMT = abs(secondsFromGMT / 60) % 60
        let timeZoneString = String(format: "GMT%+02d:%02d", hoursFromGMT, minutesFromGMT)
        
        return  [
            "applist": [["firstTime":"1970-01-01 08:00:00","lastTime":"1970-01-01 08:00:00","name":"Tethering","packageName":"com.google.android.networkstack.tethering","systemApp":"2","versionCode":"13-9924753"]],
            "availableSpace": "\((space.storage?.available ?? 0) / 1000 / 1000 / 1000)GB",
            "back_num": "0",
            "basebandVer": "",
            "brands": device.brand,
            "complete_apply_power": batter.level,
            "complete_apply_time": nowString,
            "cpu_cores": cpu.abis.count,
            "cpu_model": "arm64-v8a",
            "deviceCreateTime": nowString,
            "deviceName": device.name,
            "gaid": device.gaid,
            "hit_num": 0,
            "imei": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "imsi": "",
            "ip": "192.168.0.1",
            "isJailBreak": device.isRooted ? "1" : "0",
            "isRooted": device.isRooted ? "1" : "0",
            "macAddress": "",
            "mobile_model": device.model,
            "network": "",
            "open_power": batter.level,
            "open_time": nowString,
            "phoneModel": device.model,
            "phoneVersion": device.version,
            "ram": "\((space.ram?.available ?? 0) / 1000 / 1000 / 1000)GB",
            "real_machine": device.isSimulator ? "1" : "0",
            "regDevice": "3",
            "regWifiAddress": "",
            "regWifiList": [],
            "rom": "\((space.storage?.total ?? 0) / 1000 / 1000 / 1000)GB",
            "root": device.isRooted ? "1" : "0",
            "resolution": screen.resolution,
            "sensorCount": "0",
            "time_zone": timeZoneString,
            "totalRam": "\((space.ram?.available ?? 0) / 1000 / 1000 / 1000)GB",
            "version": ProcessInfo().operatingSystemVersion.majorVersion,
            "wifiList": [],
            "wifi_mac": "",
            "wifi_name": "",
            "wifi_state": "0"
        ] as [String : Any]
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
