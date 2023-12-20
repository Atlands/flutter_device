

import Foundation

// MARK: - Record
struct ODEE: Codable {
    let batter: BDMD?
    let cpu: MDEL
    let createdAt: Int
    let device: MLEA
    let isTable: Bool
    let locale: MELA
    let network: MELAW
    let regDevice: Int
    let screen: LMEA
    let space: MAOE
}

// MARK: - Batter
struct BDMD: Codable {
    let level: Float
    let status: Int
}

/// CPU
// MARK: - CPU
struct MDEL: Codable {
    let abis: [String]
    let cores: Int
}

/// DeviceInfo
// MARK: - DeviceInfo
struct MLEA: Codable {
    let androidId: String
    let brand: String
    let gaid: String
    let isRooted: Bool
    let isSimulator: Bool
    let model: String
    /// 设备名称
    let name: String
    let version: String
}


// MARK: - File
//struct File: Codable {
//    let audioExternal, audioInternal: Int
//    let contactGroup: Int
//    let downloadExternal, downloadInternal, imageExternal, imageInternal: Int
//    let videoExternal, videoInternal: Int
//}


// MARK: - Locale
struct MELA: Codable {
    let country: String?
    let displayCountry: String?
    let displayLanguage: String?
    let displayName: String?
    let language: String?
    let timeZone: String?
    let timeZoneId: String?
}

// MARK: - Network
struct MELAW: Codable {
    let dns: String?
    let httpProxyPort: String?
    let isUsingProxyPort: Bool?
    let isUsingVPN: Bool?
    let networkName: String?
    let networkSubType: Int?
    let networkType: Int?
    let phoneType: Int?
    let vpnAddress: String?
}

//struct WifiInfo: Codable {
//    /// 接入点的地址
//    let bssid: String
//    /// 类型
//    let capabilities: String
//    /// 频率
//    let frequency: Int
//    let macAddress: String
//    /// 电平信号
//    let rssi: Int
//    /// Wi-Fi名称
//    let ssid: String
//}

struct LMEA: Codable {
    let brightness: Int
    let density: Double
    let height: Double
    let resolution: String
    let width: Double
}

/// 容量空间
// MARK: - Space
struct MAOE: Codable {
    let ram: MOEA?
    /// SD卡存储
//    let sd: AppClass
    /// 内部存储
    let storage: MOEA?
}

struct MOEA: Codable {
    /// 空闲，byte
    let available: Int?
    /// 全部，byte
    let total: Int?
}
