//
//  Util.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation

func getJsonString<T: Codable>(from items: T) -> String? {
    do {
        // 使用JSONEncoder类将Position列表转换为JSON数据
        let jsonData = try JSONEncoder().encode(items)
        // 使用String类将JSON数据转换为字符串，使用utf8编码
        let jsonString = String(data: jsonData, encoding: .utf8)
        // 返回json字符串
        return jsonString
    } catch {
        // 处理错误
        print(error)
        return nil
    }
}

func dictToJson(dict: Dictionary<String, Any>) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    } catch {
        return nil
    }
}

let dateFormat = DateFormatter()

//extension Double {
//
//    /// Rounds the double to decimal places value
//    func roundTo(places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//
//    }
//}

extension Double {
    // 定义一个方法，接受一个整数n作为参数，返回一个保留n位小数的Double值
    func roundTo(places n: Int) -> Double {
        // 使用pow函数计算10的n次方
        let multiplier = pow(10, Double(n))
        // 使用rounded函数对当前值乘以multiplier进行四舍五入
        let roundedValue = (self * multiplier).rounded()
        // 使用除法还原小数点的位置，并返回结果
        return roundedValue / multiplier
    }
}


// 定义一个扩展方法来判断字符串是否为空或者空白
extension Optional where Wrapped == String {
    var isNullOrEmpty: Bool {
        // 如果字符串为 nil 或者为空白，返回 true
        return self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
}


