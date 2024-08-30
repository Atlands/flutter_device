class Device {
  final Batter batter;
  final CPU cpu;
  final int createdAt;
  final DeviceInfo device;
  final File file;
  final bool isTable;
  final Locale locale;
  final Network network;
  final int regDevice;
  final WifiInfo regWifi;
  final List<WifiInfo> regWifiList;
  final Screen screen;
  final List<SensorInfo> sensorList;
  final List<Sim> sim;
  final Space space;
  final List<WifiInfo> wifiList;
  final double openPower;
  int backNum;

  Device({
    required this.batter,
    required this.cpu,
    required this.createdAt,
    required this.device,
    required this.file,
    required this.isTable,
    required this.locale,
    required this.network,
    this.regDevice = 4,
    required this.regWifi,
    required this.regWifiList,
    required this.screen,
    required this.sensorList,
    required this.sim,
    required this.space,
    required this.wifiList,
    required this.openPower,
    required this.backNum,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      batter: Batter.fromJson(json['batter']),
      cpu: CPU.fromJson(json['cpu']),
      createdAt: json['createdAt'],
      device: DeviceInfo.fromJson(json['device']),
      file: File.fromJson(json['file']),
      isTable: json['isTable'],
      locale: Locale.fromJson(json['locale']),
      network: Network.fromJson(json['network']),
      regDevice: json['regDevice'] ?? 4,
      regWifi: WifiInfo.fromJson(json['regWifi']),
      regWifiList: (json['regWifiList'] as List)
          .map((i) => WifiInfo.fromJson(i))
          .toList(),
      screen: Screen.fromJson(json['screen']),
      sensorList: (json['sensorList'] as List)
          .map((i) => SensorInfo.fromJson(i))
          .toList(),
      sim: (json['sim'] as List).map((i) => Sim.fromJson(i)).toList(),
      space: Space.fromJson(json['space']),
      wifiList:
          (json['wifiList'] as List).map((i) => WifiInfo.fromJson(i)).toList(),
      openPower: json['openPower'],
      backNum: json['backNum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batter': batter.toJson(),
      'cpu': cpu.toJson(),
      'createdAt': createdAt,
      'device': device.toJson(),
      'file': file.toJson(),
      'isTable': isTable,
      'locale': locale.toJson(),
      'network': network.toJson(),
      'regDevice': regDevice,
      'regWifi': regWifi.toJson(),
      'regWifiList': regWifiList.map((i) => i.toJson()).toList(),
      'screen': screen.toJson(),
      'sensorList': sensorList.map((i) => i.toJson()).toList(),
      'sim': sim.map((i) => i.toJson()).toList(),
      'space': space.toJson(),
      'wifiList': wifiList.map((i) => i.toJson()).toList(),
      'openPower': openPower,
      'backNum': backNum,
    };
  }
}

class Batter {
  final bool existed;
  final int chargeType;
  final int health;
  final double level;
  final int maxCapacity;
  final int nowCapacity;
  final int status;
  final String technology;
  final int temperature;

  Batter({
    this.existed = true,
    this.chargeType = 0,
    this.health = 1,
    this.level = 0.0,
    this.maxCapacity = 0,
    this.nowCapacity = 0,
    this.status = 1,
    this.technology = "",
    this.temperature = 0,
  });

  factory Batter.fromJson(Map<String, dynamic> json) {
    return Batter(
      existed: json['existed'] ?? true,
      chargeType: json['chargeType'] ?? 0,
      health: json['health'] ?? 1,
      level: json['level'] ?? 0.0,
      maxCapacity: json['maxCapacity'] ?? 0,
      nowCapacity: json['nowCapacity'] ?? 0,
      status: json['status'] ?? 1,
      technology: json['technology'] ?? "",
      temperature: json['temperature'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'existed': existed,
      'chargeType': chargeType,
      'health': health,
      'level': level,
      'maxCapacity': maxCapacity,
      'nowCapacity': nowCapacity,
      'status': status,
      'technology': technology,
      'temperature': temperature,
    };
  }
}

// Similarly, implement other classes (CPU, DeviceInfo, File, Locale, Network, WifiInfo, Screen, SensorInfo, Sim, Space, AppClass)
// with their respective fromJson and toJson methods

class CPU {
  final List<String> abis;
  final int cores;
  final int frequencyMax;
  final int frequencyMin;
  final String name;

  CPU({
    required this.abis,
    required this.cores,
    required this.frequencyMax,
    required this.frequencyMin,
    required this.name,
  });

  factory CPU.fromJson(Map<String, dynamic> json) {
    return CPU(
      abis: List<String>.from(json['abis']),
      cores: json['cores'],
      frequencyMax: json['frequencyMax'],
      frequencyMin: json['frequencyMin'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abis': abis,
      'cores': cores,
      'frequencyMax': frequencyMax,
      'frequencyMin': frequencyMin,
      'name': name,
    };
  }
}

class DeviceInfo {
  final String? androidId;
  final String? baseBandVersion;
  final int bluetoothCount;
  final String? bluetoothMac;
  final String? board;
  final String? brand;
  final String? buildFingerprint;
  final String? buildId;
  final int buildNumber;
  final int buildTime;
  final int elapsedRealtime;
  final String? gaid;
  final String? gsfid;
  final String? host;
  String imei;
  String imsi;
  final bool isAirplane;
  final bool isGpsFaked;
  final bool isRooted;
  final bool isSimulator;
  final bool isUSBDebug;
  final String? kernelVersion;
  final String? keyboard;
  final int lastBootTime;
  final String? macAddress;
  final String? manufacturerName;
  String meid;
  final String? model;
  final String? name;
  final bool physicalKeyboard;
  final String? radioVersion;
  final int ringerMode;
  final String? serial;
  final int updateMills;
  final String? version;
  final String? securityPatch;
  final String? release;

  DeviceInfo({
    this.androidId = "",
    this.baseBandVersion = "",
    this.bluetoothCount = 0,
    this.bluetoothMac = "",
    this.board = "",
    this.brand = "",
    this.buildFingerprint = "",
    this.buildId = "",
    this.buildNumber = 0,
    this.buildTime = 0,
    this.elapsedRealtime = 0,
    this.gaid = "",
    this.gsfid = "",
    this.host = "",
    required this.imei,
    required this.imsi,
    this.isAirplane = false,
    this.isGpsFaked = false,
    this.isRooted = false,
    this.isSimulator = false,
    this.isUSBDebug = false,
    this.kernelVersion = "",
    this.keyboard = "",
    this.lastBootTime = 0,
    this.macAddress = "",
    this.manufacturerName = "",
    required this.meid,
    this.model = "",
    this.name = "",
    this.physicalKeyboard = false,
    this.radioVersion = "",
    this.ringerMode = -1,
    this.serial = "",
    this.updateMills = 0,
    this.version = "",
    this.securityPatch = "",
    this.release = "",
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      androidId: json['androidId'],
      baseBandVersion: json['baseBandVersion'],
      bluetoothCount: json['bluetoothCount'] ?? 0,
      bluetoothMac: json['bluetoothMac'],
      board: json['board'],
      brand: json['brand'],
      buildFingerprint: json['buildFingerprint'],
      buildId: json['buildId'],
      buildNumber: json['buildNumber'] ?? 0,
      buildTime: json['buildTime'] ?? 0,
      elapsedRealtime: json['elapsedRealtime'] ?? 0,
      gaid: json['gaid'],
      gsfid: json['gsfid'],
      host: json['host'],
      imei: json['imei'] ?? "",
      imsi: json['imsi'] ?? "",
      isAirplane: json['isAirplane'] ?? false,
      isGpsFaked: json['isGpsFaked'] ?? false,
      isRooted: json['isRooted'] ?? false,
      isSimulator: json['isSimulator'] ?? false,
      isUSBDebug: json['isUSBDebug'] ?? false,
      kernelVersion: json['kernelVersion'],
      keyboard: json['keyboard'],
      lastBootTime: json['lastBootTime'] ?? 0,
      macAddress: json['macAddress'],
      manufacturerName: json['manufacturerName'],
      meid: json['meid'] ?? "",
      model: json['model'],
      name: json['name'],
      physicalKeyboard: json['physicalKeyboard'] ?? false,
      radioVersion: json['radioVersion'],
      ringerMode: json['ringerMode'] ?? -1,
      serial: json['serial'],
      updateMills: json['updateMills'] ?? 0,
      version: json['version'],
      securityPatch: json['securityPatch'],
      release: json['release'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'androidId': androidId,
      'baseBandVersion': baseBandVersion,
      'bluetoothCount': bluetoothCount,
      'bluetoothMac': bluetoothMac,
      'board': board,
      'brand': brand,
      'buildFingerprint': buildFingerprint,
      'buildId': buildId,
      'buildNumber': buildNumber,
      'buildTime': buildTime,
      'elapsedRealtime': elapsedRealtime,
      'gaid': gaid,
      'gsfid': gsfid,
      'host': host,
      'imei': imei,
      'imsi': imsi,
      'isAirplane': isAirplane,
      'isGpsFaked': isGpsFaked,
      'isRooted': isRooted,
      'isSimulator': isSimulator,
      'isUSBDebug': isUSBDebug,
      'kernelVersion': kernelVersion,
      'keyboard': keyboard,
      'lastBootTime': lastBootTime,
      'macAddress': macAddress,
      'manufacturerName': manufacturerName,
      'meid': meid,
      'model': model,
      'name': name,
      'physicalKeyboard': physicalKeyboard,
      'radioVersion': radioVersion,
      'ringerMode': ringerMode,
      'serial': serial,
      'updateMills': updateMills,
      'version': version,
      'securityPatch': securityPatch,
      'release': release,
    };
  }
}

class File {
  final int audioExternal;
  final int audioInternal;
  final int contactGroup;
  final int downloadExternal;
  final int downloadInternal;
  final int imageExternal;
  final int imageInternal;
  final int videoExternal;
  final int videoInternal;

  File({
    this.audioExternal = 0,
    this.audioInternal = 0,
    this.contactGroup = 0,
    this.downloadExternal = 0,
    this.downloadInternal = 0,
    this.imageExternal = 0,
    this.imageInternal = 0,
    this.videoExternal = 0,
    this.videoInternal = 0,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      audioExternal: json['audioExternal'] ?? 0,
      audioInternal: json['audioInternal'] ?? 0,
      contactGroup: json['contactGroup'] ?? 0,
      downloadExternal: json['downloadExternal'] ?? 0,
      downloadInternal: json['downloadInternal'] ?? 0,
      imageExternal: json['imageExternal'] ?? 0,
      imageInternal: json['imageInternal'] ?? 0,
      videoExternal: json['videoExternal'] ?? 0,
      videoInternal: json['videoInternal'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audioExternal': audioExternal,
      'audioInternal': audioInternal,
      'contactGroup': contactGroup,
      'downloadExternal': downloadExternal,
      'downloadInternal': downloadInternal,
      'imageExternal': imageExternal,
      'imageInternal': imageInternal,
      'videoExternal': videoExternal,
      'videoInternal': videoInternal,
    };
  }
}

class Locale {
  final String country;
  final String displayCountry;
  final String displayName;
  final String language;
  final String displayLanguage;
  final String ios3Country;
  final String iso3Language;
  final String timeZone;
  final String timeZoneId;

  Locale({
    this.country = "",
    this.displayCountry = "",
    this.displayName = "",
    this.language = "",
    this.displayLanguage = "",
    this.ios3Country = "",
    this.iso3Language = "",
    this.timeZone = "",
    this.timeZoneId = "",
  });

  factory Locale.fromJson(Map<String, dynamic> json) {
    return Locale(
      country: json['country'] ?? "",
      displayCountry: json['displayCountry'] ?? "",
      displayName: json['displayName'] ?? "",
      language: json['language'] ?? "",
      displayLanguage: json['displayLanguage'] ?? "",
      ios3Country: json['ios3Country'] ?? "",
      iso3Language: json['iso3Language'] ?? "",
      timeZone: json['timeZone'] ?? "",
      timeZoneId: json['timeZoneId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'displayCountry': displayCountry,
      'displayName': displayName,
      'language': language,
      'displayLanguage': displayLanguage,
      'ios3Country': ios3Country,
      'iso3Language': iso3Language,
      'timeZone': timeZone,
      'timeZoneId': timeZoneId,
    };
  }
}

class Network {
  final int httpProxyPort;
  final bool isUsingProxyPort;
  final bool isUsingVPN;
  final int networkType;
  final int networkSubType;
  final String networkName;
  final int phoneType;
  final String vpnAddress;
  final String dns;
  final String networkOperatorName;
  final int simCount;

  Network({
    this.httpProxyPort = 0,
    this.isUsingProxyPort = false,
    this.isUsingVPN = false,
    this.networkType = 0,
    this.networkSubType = 0,
    this.networkName = "",
    this.phoneType = 0,
    this.vpnAddress = "",
    this.dns = "",
    this.networkOperatorName = "",
    this.simCount = 0,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      httpProxyPort: json['httpProxyPort'] ?? 0,
      isUsingProxyPort: json['isUsingProxyPort'] ?? false,
      isUsingVPN: json['isUsingVPN'] ?? false,
      networkType: json['networkType'] ?? 0,
      networkSubType: json['networkSubType'] ?? 0,
      networkName: json['networkName'] ?? "",
      phoneType: json['phoneType'] ?? 0,
      vpnAddress: json['vpnAddress'] ?? "",
      dns: json['dns'] ?? "",
      networkOperatorName: json['networkOperatorName'] ?? "",
      simCount: json['simCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'httpProxyPort': httpProxyPort,
      'isUsingProxyPort': isUsingProxyPort,
      'isUsingVPN': isUsingVPN,
      'networkType': networkType,
      'networkSubType': networkSubType,
      'networkName': networkName,
      'phoneType': phoneType,
      'vpnAddress': vpnAddress,
      'dns': dns,
      'networkOperatorName': networkOperatorName,
      'simCount': simCount,
    };
  }
}

class WifiInfo {
  final String bssid;
  final String capabilities;
  final int frequency;
  final int rssi;
  final String macAddress;
  final String ssid;
  final int timestamp;

  WifiInfo({
    this.bssid = "",
    this.capabilities = "",
    this.frequency = 0,
    this.rssi = 0,
    this.macAddress = "",
    this.ssid = "",
    this.timestamp = 0,
  });

  factory WifiInfo.fromJson(Map<String, dynamic> json) {
    return WifiInfo(
      bssid: json['bssid'] ?? "",
      capabilities: json['capabilities'] ?? "",
      frequency: json['frequency'] ?? 0,
      rssi: json['rssi'] ?? 0,
      macAddress: json['macAddress'] ?? "",
      ssid: json['ssid'] ?? "",
      timestamp: json['timestamp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bssid': bssid,
      'capabilities': capabilities,
      'frequency': frequency,
      'rssi': rssi,
      'macAddress': macAddress,
      'ssid': ssid,
      'timestamp': timestamp,
    };
  }
}

class Screen {
  final int brightness;
  final double density;
  final String display;
  final int dpi;
  int width;
  int height;
  final String physicalSize;

  String get resolution => "${width}*${height}";

  Screen({
    this.brightness = 0,
    this.density = 0,
    this.display = "",
    this.dpi = 0,
    this.width = 0,
    this.height = 0,
    this.physicalSize = "0*0",
  });

  factory Screen.fromJson(Map<String, dynamic> json) {
    return Screen(
      brightness: json['brightness'] ?? 0,
      density: json['density']?.toDouble() ?? 0,
      display: json['display'] ?? "",
      dpi: json['dpi'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      physicalSize: json['physicalSize'] ?? "0*0",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brightness': brightness,
      'density': density,
      'display': display,
      'dpi': dpi,
      'width': width,
      'height': height,
      'physicalSize': physicalSize,
      'resolution': resolution,
    };
  }
}

class SensorInfo {
  final double maxRange;
  final int minDelay;
  final String name;
  final double power;
  final double resolution;
  final int type;
  final String vendor;
  final int version;

  SensorInfo({
    this.maxRange = 0,
    this.minDelay = 0,
    this.name = "",
    this.power = 0,
    this.resolution = 0,
    this.type = 0,
    this.vendor = "",
    this.version = 0,
  });

  factory SensorInfo.fromJson(Map<String, dynamic> json) {
    return SensorInfo(
      maxRange: json['maxRange']?.toDouble() ?? 0,
      minDelay: json['minDelay'] ?? 0,
      name: json['name'] ?? "",
      power: json['power']?.toDouble() ?? 0,
      resolution: json['resolution']?.toDouble() ?? 0,
      type: json['type'] ?? 0,
      vendor: json['vendor'] ?? "",
      version: json['version'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxRange': maxRange,
      'minDelay': minDelay,
      'name': name,
      'power': power,
      'resolution': resolution,
      'type': type,
      'vendor': vendor,
      'version': version,
    };
  }
}

class Sim {
  final String carrierName;
  String cid;
  String countryISO;
  int dbm;
  final String iccid;
  String mcc;
  String mnc;

  String get operator => "$mcc-$mnc";
  final String phoneNumber;
  final String imsi;
  final String imei;
  final String meid;

  Sim({
    this.carrierName = "",
    this.cid = "",
    this.countryISO = "",
    this.dbm = 0,
    this.iccid = "",
    this.mcc = "",
    this.mnc = "",
    this.phoneNumber = "",
    this.imsi = "",
    this.imei = "",
    this.meid = "",
  });

  factory Sim.fromJson(Map<String, dynamic> json) {
    return Sim(
      carrierName: json['carrierName'] ?? "",
      cid: json['cid'] ?? "",
      countryISO: json['countryISO'] ?? "",
      dbm: json['dbm'] ?? 0,
      iccid: json['iccid'] ?? "",
      mcc: json['mcc'] ?? "",
      mnc: json['mnc'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      imsi: json['imsi'] ?? "",
      imei: json['imei'] ?? "",
      meid: json['meid'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carrierName': carrierName,
      'cid': cid,
      'countryISO': countryISO,
      'dbm': dbm,
      'iccid': iccid,
      'mcc': mcc,
      'mnc': mnc,
      'operator': operator,
      'phoneNumber': phoneNumber,
      'imsi': imsi,
      'imei': imei,
      'meid': meid,
    };
  }
}

class Space {
  final AppClass app;
  final AppClass ram;
  final AppClass sd;
  final AppClass storage;

  Space({
    this.app = const AppClass(),
    this.ram = const AppClass(),
    this.sd = const AppClass(),
    this.storage = const AppClass(),
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      app: AppClass.fromJson(json['app'] ?? {}),
      ram: AppClass.fromJson(json['ram'] ?? {}),
      sd: AppClass.fromJson(json['sd'] ?? {}),
      storage: AppClass.fromJson(json['storage'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app': app.toJson(),
      'ram': ram.toJson(),
      'sd': sd.toJson(),
      'storage': storage.toJson(),
    };
  }
}

class AppClass {
  final int available;
  final int total;

  const AppClass({
    this.available = 0,
    this.total = 0,
  });

  factory AppClass.fromJson(Map<String, dynamic> json) {
    return AppClass(
      available: json['available'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'total': total,
    };
  }
}
