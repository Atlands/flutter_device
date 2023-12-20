//
//  Position.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation

struct OMDWA: Codable {
//
//    enum CodingKeys: String, CodingKey {
//        case latitude = "position_x"
//        case longitude = "position_y"
//        case address = "location"
//        case geo_time = "geo_time"
//        case gps_address_province = "gps_address_province"
//        case gps_address_city = "gps_address_city"
//        case gps_address_street = "gps_address_street"
//    }

    
    var position_x: Double?
    var position_y: Double?
    var location: String?
    var geo_time: String?
    var gps_address_province: String?
    var gps_address_city: String?
    var gps_address_street: String?
}

