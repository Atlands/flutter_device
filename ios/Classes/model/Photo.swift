//
//  Photo.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation

// 定义一个结构体，表示照片信息
struct Photo: Codable {
    // 定义属性，使用CodingKey协议来指定序列化的键名
    enum CodingKeys: String, CodingKey {
        case name
        case author
        case createdAt = "addTime"
        case updatedAt = "updateTime"
        case model
        case width
        case height
        case longitude
        case latitude
//        case orientation
//        case resolutionX = "x_resolution"
//        case resolutionY = "y_resolution"
        case altitude
//        case gpsProcessingMethod = "gps_processing_method"
//        case lensMake = "lens_make"
//        case lensModel = "lens_model"
//        case focalLength = "focal_length"
//        case flash
//        case software
//        case latitudeRef = "latitude_ref"
//        case longitudeRef = "longitude_ref"
    }

    // 定义属性，使用可选类型来表示可能为空的值
    var name: String?
    var author: String?
    var createdAt: String?
    var updatedAt: String?
    var model: String?
    var width: Int?
    var height: Int?
    var longitude: Double?
    var latitude: Double?
//    var orientation: String?
//    var resolutionX: String?
//    var resolutionY: String?
    var altitude: Double?
//    var gpsProcessingMethod: String?
//    var lensMake: String?
//    var lensModel: String?
//    var focalLength: String?
//    var flash: String?
//    var software: String?
//    var latitudeRef: String?
//    var longitudeRef: String?
}
