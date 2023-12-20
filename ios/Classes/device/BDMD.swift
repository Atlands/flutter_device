//
//  Batter.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension Deeml {
    func getBatter() -> BDMD {
        if !mlad.isBatteryMonitoringEnabled {
            mlad.isBatteryMonitoringEnabled = true
        }
        return BDMD(level: mlad.batteryLevel, status: getStatus())
    }
    
    private func getStatus() -> Int {
        let state = mlad.batteryState
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
