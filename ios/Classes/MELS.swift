//
//  PositionUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import CoreLocation

class MELS: NSObject {
    let male = CLLocationManager()
    private var _result: ((BACKBODY<String?>) -> Void)? = nil
    
    func select(onResult: @escaping ((BACKBODY<String?>) -> Void)){
        self._result = onResult
        male.delegate = self
        if(kmla()){
            back()
        } else {
            male.requestWhenInUseAuthorization()
        }
    }
    
    private func back() {
        if !CLLocationManager.locationServicesEnabled() {
            self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
            self._result = nil
            return
        }
        male.desiredAccuracy = kCLLocationAccuracyBest
        male.requestLocation()
    }
    
    private func kmla() -> Bool {
        let emla: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            emla = male.authorizationStatus
        } else {
            emla = CLLocationManager.authorizationStatus()
        }
        return emla == .authorizedWhenInUse || emla == .authorizedAlways
    }
}

extension MELS: CLLocationManagerDelegate {
    //MARK: - ios 14.0-
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mead()
    }
    
    //MARK: - ios 14.0+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        mead()
    }
    
    private func mead() {
        if kmla() {
            back()
        } else {
            self._result?(BACKBODY(code: ResultError.locationPermission, message: "gps permission denied", data: nil))
            self._result = nil
        }
    }
    
    //MARK: - 获取定位后的经纬度
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last {
            var position = OMDWA(
                position_x: loction.coordinate.latitude.roundTo(places: 2),
                position_y: loction.coordinate.longitude.roundTo(places: 2))
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(loction){ placemark,_ in
                position.geo_time = format.string(from: Date())
                if let mark = placemark?.first {
                    position.gps_address_province = mark.administrativeArea
                    position.gps_address_city = mark.locality
                    position.gps_address_street = mark.thoroughfare
                    position.location = mark.melda()
                }
                
                self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: mlea(from: position)))
                self._result = nil
            }
        } else {
            self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
            self._result = nil
        }
    }
    
    //MARK: 获取定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("get location failed. error:\(error.localizedDescription)")
        self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
        self._result = nil
    }
}

extension CLPlacemark {

    func melda() -> String {
        return [subThoroughfare, thoroughfare, locality, administrativeArea, postalCode, country]
            .compactMap({ $0 })
            .joined(separator: " ")
    }
}
