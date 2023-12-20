//
//  Space.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension Deeml {
    func getSpace() -> MAOE {
        
        return MAOE(ram: MOEA(available: nil, total: Int(amlde.physicalMemory)), storage: getStorage())
    }
    
    private func getStorage() -> MOEA? {
        // 获取设备的根目录路径
        let rootPath = NSHomeDirectory()

        // 获取设备的存储容量信息
        if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: rootPath) {
            // 获取总容量，返回一个字节为单位的数值
            let totalBytes = systemAttributes[FileAttributeKey.systemSize] as? Int
            
            // 获取可用容量，返回一个字节为单位的数值
            let freeBytes = systemAttributes[FileAttributeKey.systemFreeSize] as? Int
            return MOEA(available: freeBytes, total: totalBytes)
        } else {
            return nil
        }
    }
}
