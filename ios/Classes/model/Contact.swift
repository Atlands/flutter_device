//
//  Contact.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

//class Contact{
//    let  displayName: String
//    let  phone: String
//
//    init(displayName: String, phone: String) {
//        self.displayName = displayName
//        self.phone = phone
//    }
//
//    func toPickerJson() -> String? {
//        let map = ["displayName": displayName, "phone": phone]
//        return dictToJson(dict: map)
//    }
//}

struct Contact: Codable {
    // 联系次数
//    var contactedTimes: Int
    // 最后联系时间
//    var contactedUpdateAt: Int
    // 联系人显示名称
    var displayName: String?
    // 姓，家庭名称
    var familyName: String?
    // 名，主要名字
    var giveName: String?
    // 手机号
    var phone: String?
    // 邮箱
    var email: String?
    // 是否收藏
//    var starred: Bool
    // 更新时间
//    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
//        case contactedTimes = "contactedTimes"
//        case contactedUpdateAt = "contactedUpdateAt"
        case displayName = "other_name"
        case email = "email"
        case familyName = "lastName"
        case giveName = "firstName"
        case phone = "other_mobile"
//        case starred = "starred"
//        case updatedAt = "last_time"
    }
}
