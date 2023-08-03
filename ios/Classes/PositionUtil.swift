//
//  PositionUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import CoreLocation

class PositionUtil: NSObject {
    let locationManager = CLLocationManager()
    private var onResult: ((Result<String?>) -> Void)? = nil
    
    func picker(onResult: @escaping ((Result<String?>) -> Void)){
        self.onResult = onResult
        locationManager.delegate = self
        if(hasPermission()){
            request()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func request() {
        if !CLLocationManager.locationServicesEnabled() {
            self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
            self.onResult = nil
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    private func hasPermission() -> Bool {
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
}

extension PositionUtil: CLLocationManagerDelegate {
    //MARK: - ios 14.0 之前，获取权限结果的方法
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        permissionRes()
    }
    
    //MARK: - ios 14.0，获取权限结果的方法
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permissionRes()
    }
    
    private func permissionRes() {
        if hasPermission() {
            request()
        } else {
            self.onResult?(Result(code: ResultError.locationPermission, message: "gps permission denied", data: nil))
            self.onResult = nil
        }
    }
    
    //MARK: - 获取定位后的经纬度
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last {
            var position = Position(
                latitude: loction.coordinate.latitude.roundTo(places: 2),
                longitude: loction.coordinate.longitude.roundTo(places: 2))
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(loction){ placemark,_ in
                position.geo_time = dateFormat.string(from: Date())
                if let mark = placemark?.first {
                    position.gps_address_province = mark.administrativeArea
                    position.gps_address_city = mark.locality
                    position.gps_address_street = mark.thoroughfare
                    position.address = mark.makeAddressString()
                }
                
                self.onResult?(Result(code: ResultError.resultOK, message: nil, data: getJsonString(from: position)))
                self.onResult = nil
            }
        } else {
            self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
            self.onResult = nil
        }
    }
    
    //MARK: 获取定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("get location failed. error:\(error.localizedDescription)")
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
        self.onResult = nil
    }
}

extension CLPlacemark {

    func makeAddressString() -> String {
        return [subThoroughfare, thoroughfare, locality, administrativeArea, postalCode, country]
            .compactMap({ $0 })
            .joined(separator: " ")
    }
}
