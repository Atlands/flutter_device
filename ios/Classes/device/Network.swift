//
//  Network.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation
import Network
import Reachability
import CoreTelephony

extension DeviceUtil {
    func getNetwork() -> Network {
        
        // 获取系统的代理设置
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        
        // 获取 DNS 地址，如果有多个 DNS 地址，取第一个
        let dnsAddresses = nsDict["ServerAddresses"] as? [String]
        let dns = dnsAddresses?.first ?? ""
        
        // 获取 HTTP 代理地址和端口，如果没有 HTTP 代理，返回空字符串
        let httpProxyHost = nsDict["HTTPProxy"] as? String ?? ""
        let httpProxyPort = nsDict["HTTPPort"] as? Int ?? -1
        
        // 判断是否使用代理，如果 HTTP 或 HTTPS 或 SOCKS 的代理地址不为空，则认为使用了代理
        let isUsingProxyPort = !((nsDict["HTTPProxy"] as? String).isNullOrEmpty &&
                                 (nsDict["HTTPSProxy"] as? String).isNullOrEmpty &&
                                 (nsDict["SOCKSProxy"] as? String).isNullOrEmpty)
        
        // 判断是否使用 VPN，如果有 tap、tun、ppp、ipsec 等接口，说明连接了 VPN
        let keys = nsDict["__SCOPED__"] as! NSDictionary
        var isUsingVPN = false
        for key: String in keys.allKeys as! [String] {
            if (key == "tap" || key == "tun" || key == "ppp" || key == "ipsec" || key == "ipsec0") {
                isUsingVPN = true
                break
            }
        }
        
        
        // 获取 VPN 代理地址，如果有 ipsec0 接口，取它的地址，否则返回空字符串
        let vpnAddress = (keys["ipsec0"] as? Dictionary<String, Any>)?["ServerAddress"] as? String ?? ""
        
        // 获取网络制式名称，如果有 ipsec0 接口，取它的名称，否则返回空字符串
        let networkName = (keys["ipsec0"] as? Dictionary<String, Any>)?["InterfaceName"] as? String ?? ""
        
        // 创建一个 Network 对象，并赋值查询到的信息
        return Network(
            dns: dns,
            httpProxyPort: "\(httpProxyPort)",
            isUsingProxyPort: isUsingProxyPort,
            isUsingVPN: isUsingVPN,
            networkName: networkName,
            networkSubType: getCellularType(),
            networkType: getNetwrokType(),
            phoneType: getPhoneType(),
            vpnAddress: vpnAddress)
    }
    
    
    private func getPhoneType() -> Int {
        let networkInfo = CTTelephonyNetworkInfo ()
        if #available(iOS 12.0, *) {
            let carrierType = networkInfo.serviceCurrentRadioAccessTechnology
            guard let carrierTypeName = carrierType?.first?.value else {
                return 0
            }
            switch carrierTypeName {
            case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyHSUPA:
                return 1 // PHONE_TYPE_GSM
            case CTRadioAccessTechnologyCDMA1x, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB:
                return 2 // PHONE_TYPE_CDMA
            case CTRadioAccessTechnologyLTE:
                return 3 // PHONE_TYPE_SIP
            default:
                return 0
            }
        }else {
            return 0
        }
    }
    
    
    private func getCellularType () -> Int {
        let networkInfo = CTTelephonyNetworkInfo ()
        if #available(iOS 12.0, *) {
            let carrierType = networkInfo.serviceCurrentRadioAccessTechnology
            guard let carrierTypeName = carrierType?.first?.value else {
                return 0
            }
            switch carrierTypeName {
            case CTRadioAccessTechnologyGPRS:
                return 1
            case CTRadioAccessTechnologyEdge:
                return 2
            case CTRadioAccessTechnologyCDMA1x:
                return 4
            case CTRadioAccessTechnologyCDMAEVDORev0:
                return 5
            case CTRadioAccessTechnologyCDMAEVDORevA:
                return 6
            case CTRadioAccessTechnologyCDMAEVDORevB:
                return 14
            case CTRadioAccessTechnologyHSDPA:
                return 8
            case CTRadioAccessTechnologyHSUPA:
                return 9
            case CTRadioAccessTechnologyLTE:
                return 13
            case CTRadioAccessTechnologyeHRPD:
                return 14
            case CTRadioAccessTechnologyWCDMA:
                return 17
            default:
                if #available(iOS 14.1, *) {
                    if carrierTypeName == CTRadioAccessTechnologyNR {
                        return 20
                    }
                    switch carrierTypeName {
                    case CTRadioAccessTechnologyNR, CTRadioAccessTechnologyNRNSA:
                        return 20
                    default:
                        return 0
                    }
                } else {
                    return 0
                }
            }      } else {
                return 0
            }
    }
    
    
    
    private func getNetwrokType() -> Int{
        let reachability = try! Reachability()
        let networkType: Int
        switch reachability.connection {
        case .cellular:
            networkType = 0
        case .none:
            networkType  = -1
        case .unavailable:
            networkType = -1
        case .wifi:
            networkType = 1
        }
        return networkType
    }
}
