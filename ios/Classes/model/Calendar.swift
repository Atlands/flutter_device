//
//  Calendar.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

struct Calendar: Codable {
    let id: String?
    let eventTitle: String?
    let description: String?
    let startTime: String?
    let endTime: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case eventTitle = "event_title"
        case description
        case startTime = "start_time"
        case endTime = "end_time"
        case createdAt
    }
}
