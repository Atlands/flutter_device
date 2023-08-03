//
//  Result.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

class Result<T> {
    let code: Int;
        let message: String?;
        let data: T;
    
    init(code: Int,message: String?, data: T) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct ResultError {
    static let resultOK = 200
    static let packageException = 100001
    static let cameraPermission = 100002
    static let contactPermission = 100003
    static let storagePermission = 100004
    static let messagePermission = 100005
    static let calendarPermission = 100006
    static let locationPermission = 100007
    static let callLogPermission = 100008
    static let referrerError = 100009
    static let cameraNo = 100010
}

