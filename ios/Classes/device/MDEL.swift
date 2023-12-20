//
//  CPU.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation
import MachO
extension Deeml {
    func getCPU() -> MDEL {
        return MDEL(abis: [getArchitecture()], cores: amlde.processorCount)
    }
    
    
    private func getArchitecture() -> String{
        guard let arch = NXGetLocalArchInfo().pointee.name else {
            return ""
        }
        return String(cString: arch)
    }
}
