import 'package:flutter_device/flutter_device.dart';
import 'package:flutter_device/model/device.dart';
import 'package:flutter_device/model/utils.dart';

extension VNDevice on FlutterDevice {
  static Future<Map<String, dynamic>> getVNDevice() async {
    var deviceJson = await FlutterDevice.getDeviceInfo();
    var data = Device.fromJson(deviceJson);
    var packages = await FlutterDevice.getApps();
    return {
      'regWifiAddress': data.regWifi.macAddress,
      // ip: '',
      'imsi': data.device.imsi,
      'wifiMac': data.regWifi.macAddress,
      'completeApplyTime': data.createdAt.toDate(),
      'backNum': 0,
      'cpuModel': data.cpu.abis.first,
      'wifiState': data.regWifi.rssi.toString(),
      'regWifiList': data.regWifiList.map((e) => e.ssid).toList(),
      'totalRam': data.space.ram.total.toGB(),
      'realMachine': data.device.isSimulator ? '0' : '1',
      'deviceName': data.device.name ?? "",
      'imei': data.device.imei,
      'version': data.device.version ?? '',
      'macAddress': data.device.macAddress ?? '',
      'openPower': data.batter.level.toString(),
      'applist': (packages)
          .map((i) => {
                'name': i['appName'],
                'firstTime': (i['createdAt'] as int).toDate(),
                'lastTime': (i['updatedAt'] as int).toDate(),
                'versionCode': i['version'],
                'systemApp': i['isSystem'] ? '1' : '0',
                'packageName': i['packageName'],
              })
          .toList(),
      'sensorCount': data.sensorList.length.toString(),
      'ram':
          '${data.space.ram.available.toGB()}/${data.space.ram.total.toGB()}',
      'screen': 1,
      'cpuCores': data.cpu.cores.toString(),
      'openTime': data.createdAt.toDate(),
      'brands': data.device.board ?? '',
      'network': '',
      'regDevice': data.regDevice.toString(),
      'timeZone': data.locale.timeZone,
      'rom':
          '${data.space.storage.available.toGB()}/${data.space.storage.total.toGB()}',
      'root': data.device.isRooted ? '1' : '0',
      'wifiName': data.regWifi.ssid,
      'mobileModel': data.device.model ?? '',
      'completeApplyPower': data.batter.level.toString(),
      'hitNum': 0,
      'gaid': data.device.gaid ?? '',
      'availableSpace': data.space.storage.available.toGB(),
      'resolution': data.screen.resolution,
    };
  }
}
