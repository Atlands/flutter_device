//
//  CPU.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation
import MachO
extension DeviceUtil {
    func getCPU() -> CPU {
        return CPU(abis: [getArchitecture()], cores: processInfo.processorCount)
    }
    
    
    private func getArchitecture() -> String{
        guard let arch = NXGetLocalArchInfo().pointee.name else {
            return ""
        }
        return String(cString: arch)
    }
}
