//
//  PhotoUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Photos

class PhotoUtil {
    private var onResult: ((Result<[Photo]>) -> Void)? = nil
    private var photos = [Photo]()
    
    func getPhotos(onResult: @escaping ((Result<[Photo]>) -> Void)) {
        self.onResult = onResult
        
        let status =  PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            res()
        } else {
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite){ _ in
                    self.permisionRes()
                }
            } else {
                PHPhotoLibrary.requestAuthorization{ _ in
                    self.permisionRes()
                }
            }
        }
    }
    
    private func permisionRes(){
        let status =  PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            res()
        } else {
            self.onResult?(Result(code: ResultError.storagePermission, message: "photo permission denied", data: []))
            self.onResult = nil
        }
    }
    
    private func res() {
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: allPhoto()))
        self.onResult = nil
    }
    
    private func allPhoto() -> [Photo] {
        if !photos.isEmpty {
            return photos
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let timestamp = UserDefaults.standard.integer(forKey: "flutter.photo_list_date")
        fetchOptions.predicate = NSPredicate(format: "modificationDate > %@", NSDate.init(timeIntervalSinceReferenceDate: TimeInterval(timestamp)))

        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        for i in 0..<assets.count{
            let asset = assets.object(at: i)
            let photo =  Photo(
                name: asset.value(forKey: "filename") as? String ?? "",
                createdAt: dateFormat.string(from: asset.creationDate ?? Date()),
                updatedAt: dateFormat.string(from: asset.modificationDate ?? Date()),
                model: UIDevice.current.model, width: asset.pixelWidth,
                height: asset.pixelHeight,
                longitude: asset.location?.coordinate.longitude.magnitude ?? 0.0,
                latitude: asset.location?.coordinate.latitude.magnitude ?? 0.0,
                altitude: asset.location?.altitude.magnitude ?? 0.0
            )
            photos.append(photo)
        }
        return photos
    }
}
