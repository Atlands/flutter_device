package com.qc.device.model

data class Device(
    /**
     * 电池
     */
    val batter: Batter,

    /**
     * CPU
     */
    val cpu: CPU,

    /**
     * 信息抓取时间，时间戳
     */
    val createdAt: Long,

    val device: DeviceInfo,

    /**
     * 需要存储权限
     */
    val file: File,

    /**
     * 是否平板
     */
    val isTable: Boolean,

    /**
     * 本地化信息
     */
    val locale: Locale,

    val network: Network,

    /**
     * 注册设备类型1: Laptop 2: Web 3: iOS 4: Android
     */
    val regDevice: Int = 4,

    /**
     * 需要精确GPS定位
     */
    val regWifi: WifiInfo,

    /**
     * 注册的Wi-Fi列表，configuredNetworks
     * 需要精确GPS定位
     */
    val regWifiList: List<WifiInfo>,

    /**
     * 屏幕相关
     */
    val screen: Screen,

    /**
     * 传感器
     */
    val sensorList: List<SensorInfo>,

    val sim: List<Sim>,

    /**
     * 容量空间
     */
    val space: Space,

    /**
     * 扫描环境列表，需要精确GPS定位
     */
    val wifiList: List<WifiInfo>
) {

    /**
     * 电池
     */
    data class Batter(
        val existed: Boolean,
        /**
         * 充电类型，0: 没有充电
         * 1: BATTERY_PLUGGED_AC（充电器）
         * 2: BATTERY_PLUGGED_USB（USB充电）
         * 3: BATTERY_PLUGGED_ANY（其它）
         */
        val chargeType: Int,

        /**
         * 健康度，1:   BATTERY_HEALTH_UNKNOWN（未知）
         * 2：BATTERY_HEALTH_GOOD（良好）
         * 3：BATTERY_HEALTH_OVERHEAT（过热）
         * 4：BATTERY_HEALTH_DEAD（没电）
         * 5：BATTERY_HEALTH_OVER_VOLTAGE（过电压）
         * 6：BATTERY_HEALTH_UNSPECIFIED_FAILURE（未知错误）
         * 7：BATTERY_HEALTH_COLD（温度过低）
         */
        val health: Int,

//        /**
//         * 是否交流电充电
//         */
//        val isAcCharge: Boolean,
//
//        /**
//         * 是否Usb充电
//         */
//        val isUsbCharge: Boolean,

        /**
         * 电量百分比，0.95
         */
        val level: Double,

        /**
         * 最大容量
         */
        val maxCapacity: Int,

        /**
         * 现在容量
         */
        val nowCapacity: Int,

        /**
         * 电池状态，1：未知状态
         * 2：充电中
         * 3：放电中
         * 4：未充电
         * 5：充满
         */
        val status: Int,

        /**
         * 技术
         */
        val technology: String,

        /**
         * 温度
         */
        val temperature: Int
    )

    /**
     * CPU
     */
    data class CPU(
        /**
         * 设备指令集名称
         */
        val abis: List<String>,

//        /**
//         * 第二个指令集名称
//         */
//        val abi2: String,

        /**
         * 芯片架构
         */
//        val architecture: String?,

        /**
         * 核心数
         */
        val cores: Int,

        /**
         * 最大频率
         */
        val frequencyMax: Long?,

        /**
         * 最小频率
         */
        val frequencyMin: Long?,

        /**
         * 名字
         */
        val name: String?
    )

    /**
     * 设备信息
     */
    data class DeviceInfo(
        /**
         * android ID
         */
        val androidId: String,

        /**
         * 基带版本
         */
        val baseBandVersion: String,

        /**
         * 蓝牙数量
         */
        val bluetoothCount: Long,

        /**
         * 蓝牙mac
         */
        val bluetoothMac: String,

        /**
         * 主板
         */
        val board: String,

        /**
         * 手机品牌
         */
        val brand: String,

        /**
         * 指纹信息
         */
        val buildFingerprint: String,

        /**
         * 版本ID
         */
        val buildId: String,

        /**
         * 版本号
         */
        val buildNumber: String,

        /**
         * 版本日期
         */
        val buildTime: String,

        /**
         * 设备启动后的毫秒，包括休眠时间
         */
        val elapsedRealtime: Long,

        /**
         * 广告id，可能获取不到、或者全是0那种
         * 1. 必须安装google 框架才能获取
         * 2. 用户可随意重置
         * 3. 用户可关闭，关闭后获取的值：0000-0000-0000-0000
         */
        val gaid: String,

        /**
         * Google Services Framework GSF ID ，谷歌服务框架ID
         * > 任何的卸载重置此ID都会发生变化
         * > 还有说法：GSF ID 就是Android ID（注意：需要翻墙联网才能获取到）
         */
        val gsfid: String,

        /**
         * 执行代码编译的Host值
         */
        val host: String,

        /**
         * 设备号，android 10以下能取到
         */
        val imei: String,

        val imsi: String,

        /**
         * 是否飞行模式
         */
        val isAirplane: Boolean,

        /**
         * 是否定位欺骗
         */
        val isGpsFaked: Boolean,

        /**
         * 是否Root，Android 是否Root
         * iOS 是否越狱
         */
        val isRooted: Boolean,

        /**
         * 是否模拟器
         */
        val isSimulator: Boolean,

        /**
         * 是否开启USB 调试false or true
         */
        val isUSBDebug: Boolean,

        /**
         * 内核版本，应该是Linux版本
         */
        val kernelVersion: String,

        /**
         * 连接到设备的键盘类型
         */
        val keyboard: String,

        /**
         * 最后一次启动时间
         */
        val lastBootTime: Long,

        /**
         * mac地址
         */
        val macAddress: String,

        /**
         * 制造商
         */
        val manufacturerName: String,

        /**
         * 移动设备识别码
         */
        val meid: String,

        /**
         * 手机型号
         */
        val model: String,

        /**
         * 设备名称
         */
        val name: String,

        /**
         * 底部是否有物理按键
         */
        val physicalKeyboard: Boolean,

        /**
         * 无线电固件版本
         */
        val radioVersion: String,

        /**
         * 响铃模式，-1: 未知
         * 0：RINGER_MODE_SILENT（静音模式）
         * 1：RINGER_MODE_VIBRATE（震动模式）
         * 2：RINGER_MODE_NORMAL（铃音模式）
         */
        val ringerMode: Long,

        /**
         * 序列号
         */
        val serial: String,

        /**
         * 设备启动后的毫秒，不包括休眠时间
         */
        val updateMills: Long,

        /**
         * 系统版本
         */
        val version: String
    )

    /**
     * 需要存储权限
     */
    data class File(
        val audioExternal: Int,
        val audioInternal: Int,

        /**
         * 联系⼈小组个数，基数默认偏大，会算上自带群组名
         */
        val contactGroup: Int,

        val downloadExternal: Int,
        val downloadInternal: Int,
        val imageExternal: Int,
        val imageInternal: Int,
        val videoExternal: Int,
        val videoInternal: Int
    )

    /**
     * 本地化信息
     */
    data class Locale(
        val country: String,
        val displayCountry: String,
        val displayName: String,
        val language: String,

        /**
         * 区域语言名称，例如：en_US
         */
        val displayLanguage: String,

        /**
         * 语言环境所在的国家字母缩写
         */
        val ios3Country: String,

        /**
         * 语言环境的3 字母缩写
         */
        val iso3Language: String,

        /**
         * 时区示例CST
         */
        val timeZone: String,

        /**
         * 设备默认时区
         */
        val timeZoneId: String
    )

    data class Network(
        /**
         * http代理host:port
         */
        val httpProxyPort: String,

        /**
         * 是否使用代理false or true
         */
        val isUsingProxyPort: Boolean,

        /**
         * 是否使用vpn
         */
        val isUsingVPN: Boolean,

        /**
         * 网络类型，网络类型
         * unknown：0，
         * GPRS：1，
         * EDGE： 2，
         * UMTS：3，
         * CDMA: Either IS95A or IS95B：4，
         * EVDO revision 0：5
         */
        val nettype: Long,

        /**
         * 设备网络类型，NETWORK_2G
         * NETWORK_3G
         * NETWORK_4G
         * NETWORK_5G
         * NETWORK_WIFI
         */
        val networkType: String,

        /**
         * 指示设备电话类型的常量，这表示用于传输语音呼叫的无线电的类型
         */
        val phoneType: Long,

        /**
         * VPN代理地址
         */
        val vpnAddress: String
    )

    /**
     * 需要精确GPS定位
     *
     * Wi-Fi信息
     *
     * 注册的Wi-Fi列表，configuredNetworks
     * 需要精确GPS定位
     */
    data class WifiInfo(
        /**
         * 接入点的地址
         */
        val bssid: String? = null,

        /**
         * 类型
         */
        val capabilities: String? = null,

        /**
         * 频率
         */
        val frequency: Int? = null,

//        /**
//         * 路由器IP
//         */
//        val ip: String? = null,

        /**
         * 电平信号，rssi
         */
        val rssi: Int? = null,

        val macAddress: String? = null,

        /**
         * Wi-Fi名称
         */
        val ssid: String? = null,

        val timestamp: Long? = null
    )

    /**
     * 屏幕相关
     */
    data class Screen(
        /**
         * 屏幕亮度，0-255
         */
        val brightness: Int? = null,

        /**
         * 密度，像素比例：0.75/1.0/1.5/2.0
         */
        val density: Float? = null,

        /**
         * 显示屏参数
         */
        val display: String? = null,

        /**
         * 屏幕密度，每寸像素：120/160/240/320
         */
        val dpi: Int? = null,

        /**
         * 高
         */
        var height: Int? = null,

        /**
         * 物理尺寸，宽*高
         */
        val physicalSize: String? = null,

        /**
         * 分辨率，1080*1920
         */
        val resolution: String? = null,

        /**
         * 宽
         */
        var width: Int? = null
    )

    data class SensorInfo(
        /**
         * 传感器单元中传感器的最大范围，"39.2266"
         */
        val maxRange: Float? = null,

        /**
         * 两个事件之间允许的最小延迟
         */
        val minDelay: Int? = null,

        /**
         * 名字
         */
        val name: String? = null,

        /**
         * 功率(mA)
         */
        val power: Float? = null,

        /**
         * 传感器的精度
         */
        val resolution: Float? = null,

        /**
         * 通用类型
         */
        val type: Int? = null,

        /**
         * 供应商
         */
        val vendor: String? = null,

        /**
         * 版本号
         */
        val version: Int? = null
    )

    data class Sim(
        /**
         * 网络运营商名称
         */
        val carrierName: String? = null,

        /**
         * 基站编号
         */
        val cid: String? = null,

        /**
         * sim卡ISO国家代码，等同于SIM提供商的国家代码
         */
        val countryISO: String? = null,

        /**
         * 手机信号强度
         */
        val dbm: String? = null,

        val dns: String? = null,

        /**
         * 集成电路卡识别码
         */
        val iccid: String? = null,

        /**
         * 卡槽移动设备身份码
         */
        val imei: String? = null,

        /**
         * sim卡移动用户身份，android 10以下能取到
         */
        val imsi: String? = null,

        /**
         * Mcc/IMSIMCC（移动国家代码）
         */
        val mcc: String? = null,

        /**
         * 移动设备识别码，卡槽移动设备身份码1(android10及以上无法取)
         */
        val meid: String? = null,

        /**
         * Mnc/IMSIMNC（移动网络代码）
         */
        val mnc: String? = null,

        /**
         * 当前网络类型，NETWORK_2G
         * NETWORK_3G
         * NETWORK_4G
         * NETWORK_5G
         */
        val networkType: String? = null,

        /**
         * 当前注册运营商的数字名称，MCC+MNC
         */
        val operator: String? = null,

        /**
         * 手机号
         */
        val phoneNumber: String? = null,

        /**
         * sim卡的序列号
         */
        val serialNumber: String? = null,

        val subId: String? = null,
    )

    /**
     * 容量空间
     */
    data class Space(
        /**
         * 给当前app分配的容量
         */
        val app: AppClass? = null,

        /**
         * 运行内存
         */
        val ram: AppClass? = null,

        /**
         * SD卡存储
         */
        val sd: AppClass? = null,

        /**
         * 内部存储
         */
        val storage: AppClass? = null,
    )

    data class AppClass(
        /**
         * 空闲，byte
         */
        val available: Long,

        /**
         * 全部，byte
         */
        val total: Long
    )
}