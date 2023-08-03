//
//  Position.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//
// 导入Codable库，用于序列化和反序列化
import Foundation

// 定义一个结构体，表示位置信息
struct Position: Codable {
    // 定义属性，使用CodingKey协议来指定序列化的键名
    enum CodingKeys: String, CodingKey {
        case latitude = "position_x"
        case longitude = "position_y"
        case address = "location"
        case geo_time = "geo_time"
        case gps_address_province = "gps_address_province"
        case gps_address_city = "gps_address_city"
        case gps_address_street = "gps_address_street"
    }

    // 定义属性，使用可选类型来表示可能为空的值
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var geo_time: String?
    var gps_address_province: String?
    var gps_address_city: String?
    var gps_address_street: String?
}

