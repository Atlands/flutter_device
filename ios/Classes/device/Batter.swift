//
//  Batter.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension DeviceUtil {
    func getBatter() -> Batter {
        if !uiDevice.isBatteryMonitoringEnabled {
            uiDevice.isBatteryMonitoringEnabled = true
        }
        return Batter(level: uiDevice.batteryLevel, status: getStatus())
    }
    
    private func getStatus() -> Int {
        let state = uiDevice.batteryState
        switch state {
        case .unknown:
            return 1
        case .unplugged:
            return 4
        case .charging:
            return 2
        case .full:
            return 5
        @unknown default:
            return -1
        }
    }
}
