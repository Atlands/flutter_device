//
//  Device.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let request = try Request(json)

import Foundation


// MARK: - Record
struct Device: Codable {
    /// 电池
    let batter: Batter?
    /// CPU
    let cpu: CPU
    /// 信息抓取时间，时间戳
    let createdAt: Int
    let device: DeviceInfo
    /// 需要存储权限
//    let file: File
    /// 是否平板
    let isTable: Bool
    /// 本地化信息
    let locale: ULocale
    let network: Network
    /// 注册设备类型1: Laptop 2: Web 3: iOS 4: Android
    let regDevice: Int
    /// 需要精确GPS定位
//    let regWifi: WifiInfo
    /// 注册的Wi-Fi列表，configuredNetworks
    /// 需要精确GPS定位
//    let regWifiList: [WifiInfo]
    /// 屏幕相关
    let screen: Screen
    /// 传感器
//    let sensorList: [SensorList]
//    let sim: [Sim]
    /// 容量空间
    let space: Space
    /// 扫描环境列表，需要精确GPS定位
//    let wifiList: [WifiInfo]
}

// MARK: - Batter
struct Batter: Codable {
    /// 充电方式，1: BATTERY_PLUGGED_AC（充电器）
    /// 2: BATTERY_PLUGGED_USB（USB充电）
    /// 4: BATTERY_PLUGGED_WIRELESS（无线充电）
    /// 8: BATTERY_PLUGGED_DOCK
    ///
    /// BATTERY_PLUGGED_ANY（其它）=  BATTERY_PLUGGED_ANY =
    /// BATTERY_PLUGGED_AC | BATTERY_PLUGGED_USB | BATTERY_PLUGGED_WIRELESS
    /// | BATTERY_PLUGGED_DOCK
//    let chargeType: Int
//    /// 电池是否存在
//    let existed: Bool
    /// 健康状态，1:   BATTERY_HEALTH_UNKNOWN（未知）
    /// 2：BATTERY_HEALTH_GOOD（良好）
    /// 3：BATTERY_HEALTH_OVERHEAT（过热）
    /// 4：BATTERY_HEALTH_DEAD（电池低电）
    /// 5：BATTERY_HEALTH_OVER_VOLTAGE（过压保护）
    /// 6：BATTERY_HEALTH_UNSPECIFIED_FAILURE（未知错误）
    /// 7：BATTERY_HEALTH_COLD（温度过低）
//    let health: Int
    /// 电量百分比，0.95
    let level: Float
    /// 最大容量
//    let maxCapacity: Int
    /// 现在容量
//    let nowCapacity: Int
    /// 电池状态，
    /// 1：BATTERY_STATUS_UNKNOWN 未知状态
    /// 2：BATTERY_STATUS_CHARGING 充电中
    /// 3：BATTERY_STATUS_DISCHARGING 放电中
    /// 4：BATTERY_STATUS_NOT_CHARGING 未充电
    /// 5：BATTERY_STATUS_FULL 充满
    let status: Int
    /// 技术
//    let technology: String
    /// 温度
//    let temperature: Double
}

/// CPU
// MARK: - CPU
struct CPU: Codable {
    /// 设备指令集名称
    let abis: [String]
    /// 核心数
    let cores: Int
    /// 最大频率
//    let frequencyMax: String?
//    /// 最小频率
//    let frequencyMin: String?
//    /// 名字
//    let name: String?
}

/// DeviceInfo
// MARK: - DeviceInfo
struct DeviceInfo: Codable {
    /// android ID
    let androidId: String
    /// 基带版本
//    let baseBandVersion: String
    /// 蓝牙数量
//    let bluetoothCount: Int
    /// 蓝牙mac
//    let bluetoothMac: String
    /// 主板
//    let board: String
    /// 手机品牌
    let brand: String
    /// 指纹信息
//    let buildFingerprint: String
    /// 版本ID
//    let buildId: String
    /// 版本号
//    let buildNumber: Int
    /// 版本日期
//    let buildTime: Int
    /// 设备启动后的毫秒，包括休眠时间
//    let elapsedRealtime: Int
    /// 广告id，可能获取不到、或者全是0那种
    /// 1. 必须安装google 框架才能获取
    /// 2. 用户可随意重置
    /// 3. 用户可关闭，关闭后获取的值：0000-0000-0000-0000
    let gaid: String
    /// Google Services Framework GSF ID ，谷歌服务框架ID
    /// > 任何的卸载重置此ID都会发生变化
    /// > 还有说法：GSF ID 就是Android ID（注意：需要翻墙联网才能获取到）
//    let gsfid: String
    /// 执行代码编译的Host值
//    let host: String
    /// 设备号，android 10以下能取到
//    let imei: String
//    let imsi: String
    /// 是否飞行模式
//    let isAirplane: Bool
    /// 是否定位欺骗
//    let isGpsFaked: Bool
    /// 是否Root，Android 是否Root
    /// iOS 是否越狱
    let isRooted: Bool
    /// 是否模拟器
    let isSimulator: Bool
    /// 是否开启USB 调试false or true
//    let isUSBDebug: Bool
    /// 内核版本，应该是Linux版本
//    let kernelVersion: String
    /// 连接到设备的键盘类型
//    let keyboard: String
    /// 最后一次启动时间
//    let lastBootTime: Int
    /// mac地址
//    let macAddress: String
    /// 制造商
//    let manufacturerName: String
    /// 移动设备识别码
//    let meid: String
    /// 手机型号
    let model: String
    /// 设备名称
    let name: String
    /// 底部是否有物理按键
//    let physicalKeyboard: Bool
    /// 无线电固件版本
//    let radioVersion: String
    /// 响铃模式，-1: 未知
    /// 0：RINGER_MODE_SILENT（静音模式）
    /// 1：RINGER_MODE_VIBRATE（震动模式）
    /// 2：RINGER_MODE_NORMAL（铃音模式）
//    let ringerMode: Int
    /// 序列号
//    let serial: String
    /// 设备启动后的毫秒，不包括休眠时间
//    let updateMills: Int
    /// 系统版本
    let version: String
}

/// 需要存储权限
// MARK: - File
struct File: Codable {
    let audioExternal, audioInternal: Int
    /// 联系⼈小组个数，基数默认偏大，会算上自带群组名
    let contactGroup: Int
    let downloadExternal, downloadInternal, imageExternal, imageInternal: Int
    let videoExternal, videoInternal: Int
}

/// 本地化信息
// MARK: - Locale
struct ULocale: Codable {
    /// 返回此区域设置的国家/地区代码，该代码应为空字符串、大写的ISO 3166 2位代码或UN M.49 3位代码。
    let country: String?
    ///
    /// 返回适用于向用户显示的区域设置的国家/地区的名称。如果可能，返回的名称将被本地化为默认的DISPLAY区域设置。例如，如果区域设置为fr_fr，并且默认的DISPLAY区域设置为en_US，则getDisplayCountry（）将返回“France”；如果区域设置为en_US，并且默认的DISPLAY区域设置为fr_fr，则getDisplayCountry（）将返回“Etats-Unis”。如果返回的名称无法本地化为默认的DISPLAY区域设置（例如，我们没有克罗地亚的日语名称），则此函数将返回英文名称，并使用ISO代码作为最后的值。如果语言环境没有指定国家/地区，此函数将返回空字符串
    let displayCountry: String?
    ///
    /// 返回适用于向用户显示的区域设置的国家/地区的名称。如果可能，返回的名称将被本地化为默认的DISPLAY区域设置。例如，如果区域设置为fr_fr，并且默认的DISPLAY区域设置为en_US，则getDisplayCountry（）将返回“France”；如果区域设置为en_US，并且默认的DISPLAY区域设置为fr_fr，则getDisplayCountry（）将返回“Etats-Unis”。如果返回的名称无法本地化为默认的DISPLAY区域设置（例如，我们没有克罗地亚的日语名称），则此函数将返回英文名称，并使用ISO代码作为最后的值。如果语言环境没有指定国家/地区，此函数将返回空字符串
    let displayLanguage: String?
    ///
    /// 返回适合显示给用户的区域设置的名称。这将是由getDisplayLanguage（）、getDisplayScript（）、getDisplayCountry（）和getDisplayVariant（）组合成单个字符串所返回的值。非空值按顺序使用，第二个和后续名称放在括号中。
    let displayName: String?
    /// 返回此区域设置的国家/地区的三个字母的缩写。如果国家/地区与ISO
    /// 3166-1字母-2代码匹配，则返回相应的ISO3166-1字母-3大写代码。如果区域设置没有指定国家/地区，则这将是空字符串。
//    let ios3Country: String?
    /// 返回此区域设置语言的三个字母的缩写。如果语言与ISO 639-1双字母代码匹配，则返回相应的ISO 639-2/T三字母小写代码。ISO
    /// 639-2语言代码可以在网上找到，参见“语言名称表示代码第2部分：字母-3代码”。如果区域设置指定了三个字母的语言，则按原样返回该语言。如果区域设置未指定语言，则返回空字符串。
//    let iso3Language: String?
    /// 返回此区域设置的语言代码，返回此区域设置的语言代码。 注：ISO
    /// 639不是一个稳定的标准，有些语言的代码已经更改。Locale的构造函数识别代码已更改的语言的新代码和旧代码，但此函数始终返回旧代码。
    let language: String?
    ///
    /// 时区示例CST，以该时区的指定样式返回一个名称，该名称适合在默认区域设置中向用户显示。如果指定的夏令时为true，则会返回夏令时名称（即使此时区不遵守夏令时）。否则，将返回标准时间名称
    let timeZone: String?
    /// 设备默认时区，获取此时区的ID
    let timeZoneId: String?
}

// MARK: - Network
struct Network: Codable {
    let dns: String?
    /// http代理host:port
    let httpProxyPort: String?
    /// 是否使用代理false or true
    let isUsingProxyPort: Bool?
    /// 是否使用vpn
    let isUsingVPN: Bool?
    /// 网络制式名称，网络类型
    /// unknown：0，
    /// GPRS：1，
    /// EDGE： 2，
    /// UMTS：3，
    /// CDMA: Either IS95A or IS95B：4，
    /// EVDO revision 0：5
    let networkName: String?
    /// 网络类型，0: NETWORK_TYPE_UNKNOWN,
    /// 1: NETWORK_TYPE_GPRS,
    /// 2: NETWORK_TYPE_EDGE,
    /// 3: NETWORK_TYPE_UMTS,
    /// 4: NETWORK_TYPE_CDMA,
    /// 5: NETWORK_TYPE_EVDO_0,
    /// 6: NETWORK_TYPE_EVDO_A,
    /// 7: NETWORK_TYPE_1xRTT,
    /// 8: NETWORK_TYPE_HSDPA,
    /// 9: NETWORK_TYPE_HSUPA,
    /// 10: NETWORK_TYPE_HSPA,
    /// 11: NETWORK_TYPE_IDEN,
    /// 12: NETWORK_TYPE_EVDO_B,
    /// 13: NETWORK_TYPE_LTE,
    /// 14: NETWORK_TYPE_EHRPD,
    /// 15: NETWORK_TYPE_HSPAP,
    /// 16: NETWORK_TYPE_GSM,
    /// 17: NETWORK_TYPE_TD_SCDMA,
    /// 18: NETWORK_TYPE_IWLAN,
    /// 19: NETWORK_TYPE_LTE_CA,
    /// 20: NETWORK_TYPE_NR
    let networkSubType: Int?
    /// 网络连接类型，TYPE_MOBILE = 0;
    /// TYPE_WIFI = 1;
    /// TYPE_MOBILE_MMS = 2;
    /// TYPE_MOBILE_SUPL = 3;
    /// TYPE_MOBILE_DUN = 4;
    /// TYPE_MOBILE_HIPRI = 5;
    /// TYPE_WIMAX = 6;
    /// TYPE_BLUETOOTH = 7;
    /// TYPE_DUMMY = 8;
    /// TYPE_ETHERNET = 9;
    /// TYPE_VPN = 17;
    let networkType: Int?
    /// 指示设备电话类型的常量，这表示用于传输语音呼叫的无线电的类型
    ///
    /// 0: PHONE_TYPE_NONE
    /// 1: PHONE_TYPE_GSM
    /// 2: PHONE_TYPE_CDMA
    /// 3: PHONE_TYPE_SIP
    let phoneType: Int?
    /// VPN代理地址
    let vpnAddress: String?
}

/// 需要精确GPS定位
///
/// WifiInfo
///
/// 注册的Wi-Fi列表，configuredNetworks
/// 需要精确GPS定位
// MARK: - WifiInfo
struct WifiInfo: Codable {
    /// 接入点的地址
    let bssid: String
    /// 类型
    let capabilities: String
    /// 频率
    let frequency: Int
    let macAddress: String
    /// 电平信号
    let rssi: Int
    /// Wi-Fi名称
    let ssid: String
}

/// 屏幕相关
// MARK: - Screen
struct Screen: Codable {
    /// 屏幕亮度，0-255
    let brightness: Int
    /// 密度，像素比例：0.75/1.0/1.5/2.0
    let density: Double
    /// 显示屏参数
//    let display: String
    /// 屏幕密度，每寸像素：120/160/240/320
//    let dpi: Int
    /// 高
    let height: Double
    /// 物理尺寸，宽*高
//    let physicalSize: String
    /// 分辨率，1080*1920
    let resolution: String
    /// 宽
    let width: Double
}

// MARK: - SensorList
//struct SensorList: Codable {
//    /// 传感器单元中传感器的最大范围，"39.2266"
//    let maxRange: Double
//    /// 两个事件之间允许的最小延迟
//    let minDelay: Int
//    /// 名字
//    let name: String
//    /// 功率(mA)
//    let power: Double
//    /// 传感器的精度
//    let resolution: Double
//    /// 通用类型
//    let type: Int
//    /// 供应商
//    let vendor: String
//    /// 版本号
//    let version: Int
//}

// MARK: - Sim
//struct Sim: Codable {
//    /// 网络运营商名称
//    let carrierName: String
//    /// 基站编号
//    let cid: String
//    /// sim卡ISO国家代码，等同于SIM提供商的国家代码
//    let countryISO: String
//    /// 手机信号强度
//    let dbm: String
//    /// 集成电路卡识别码
//    let iccid: String
//    /// 卡槽移动设备身份码
//    let imei: String
//    /// sim卡移动用户身份，android 10以下能取到
//    let imsi: String
//    /// Mcc/IMSIMCC（移动国家代码）
//    let mcc: String
//    /// 移动设备识别码，卡槽移动设备身份码1(android10及以上无法取)
//    let meid: String
//    /// Mnc/IMSIMNC（移动网络代码）
//    let mnc: String
//    /// 当前注册运营商的数字名称，MCC+MNC
//    let simOperator: String
//    /// 手机号
//    let phoneNumber: String
//    let subId: String
//}

/// 容量空间
// MARK: - Space
struct Space: Codable {
    /// 给当前app分配的容量
//    let app: AppClass
    /// 运行内存
    let ram: AppClass?
    /// SD卡存储
//    let sd: AppClass
    /// 内部存储
    let storage: AppClass?
}

/// 给当前app分配的容量
///
/// Space
///
/// 运行内存
///
/// SD卡存储
///
/// 内部存储
// MARK: - AppClass
struct AppClass: Codable {
    /// 空闲，byte
    let available: Int?
    /// 全部，byte
    let total: Int?
}
