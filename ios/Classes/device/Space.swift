//
//  Space.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension DeviceUtil {
    func getSpace() -> Space {
        
        return Space(ram: AppClass(available: nil, total: Int(processInfo.physicalMemory)), storage: getStorage())
    }
    
    private func getStorage() -> AppClass? {
        // 获取设备的根目录路径
        let rootPath = NSHomeDirectory()

        // 获取设备的存储容量信息
        if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: rootPath) {
            // 获取总容量，返回一个字节为单位的数值
            let totalBytes = systemAttributes[FileAttributeKey.systemSize] as? Int
            
            // 获取可用容量，返回一个字节为单位的数值
            let freeBytes = systemAttributes[FileAttributeKey.systemFreeSize] as? Int
            return AppClass(available: freeBytes, total: totalBytes)
        } else {
            return nil
        }
    }
}
