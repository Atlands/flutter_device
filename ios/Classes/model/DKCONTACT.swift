
struct KDCONTACT: Codable {
    // displayName
    var name: String?
    var lastName: String?
    var firstName: String?
    var other_mobile: String?
    var email: String?

    enum CodingKeys: String, CodingKey {
//        case contactedTimes = "contactedTimes"
//        case contactedUpdateAt = "contactedUpdateAt"
        case name = "other_name"
        case email = "email"
        case lastName = "lastName"
        case firstName = "firstName"
        case other_mobile = "other_mobile"
//        case starred = "starred"
//        case updatedAt = "last_time"
    }
}
