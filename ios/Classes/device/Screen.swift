//
//  Screen.swift
//  flutter_device
//
//  Created by atlands on 2023/8/3.
//

import Foundation

extension DeviceUtil {
    func getScreen() -> Screen {
        let size = getSize()
        return Screen(
            brightness: getBrightness(),
            density: screen.scale,
            height: size.height,
            resolution: "\(Int(size.width)) * \(Int(size.height))",
            width: size.width)
    }
    
    private func getBrightness() -> Int {
        // 获取主屏幕的亮度，返回一个 0.0 到 1.0 之间的数值
        let currentBrightness = UIScreen.main.brightness
        
        let currentBrightnessInt = Int(currentBrightness * 255)
        
        return currentBrightnessInt
    }
    
    private func getSize() -> CGSize {
        let scale = screen.scale
        return CGSize(width: Int(scale * screen.bounds.width), height: Int(scale * screen.bounds.height))
    }
    
    private var screen: UIScreen {
        if #available(iOS 13.0, *) {
            return UIScreen.current ?? UIScreen()
        } else {
            return UIScreen.main
        }
    }
}


@available(iOS 13.0, *)
extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


@available(iOS 13.0, *)
extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
