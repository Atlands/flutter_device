//
//  CameraPicker.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation
import AVFoundation

class CameraPicker: NSObject, UINavigationControllerDelegate {
    let rootController = UIApplication.shared.delegate?.window??.rootViewController
    let controller = UIImagePickerController()
    
    private var onResult: ((Result<String?>) -> Void)? = nil
    private var font: Bool = false
    
    func picker(font: Bool, onResult: @escaping ((Result<String?>) -> Void)){
        self.font = font
        self.onResult = onResult
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            takePicture()
        }else{
            AVCaptureDevice.requestAccess(for: .video){ granted in
                if granted {
                    self.takePicture()
                } else {
                    self.onResult?(Result(
                        code: ResultError.cameraPermission,
                        message: "camera permission denied",
                        data: nil
                    ))
                    self.onResult = nil
                }
            }
        }
    }
    
    private func takePicture(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            self.onResult?(Result(code: ResultError.cameraNo, message: "the device does not have a camera", data: nil))
            self.onResult = nil
            return
        }
        DispatchQueue.main.async { [self] in
            controller.delegate = self
            controller.sourceType = .camera
            if font {
                controller.cameraDevice = .front
            }
            controller.allowsEditing = false
            if rootController != nil {
                rootController?.present(controller, animated: true)
            } else {
                self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
                self.onResult = nil
            }
        }
    }
}

extension CameraPicker: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if
            let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ,
           let data = pickedImage.jpegData(compressionQuality: 0.4),
            let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first{
            do {
                let fileName = "\(Date().timeIntervalSince1970).jpeg"
                let fileURL = cacheURL.appendingPathComponent(fileName)
                try data.write(to: fileURL)
                self.onResult?(Result(code: ResultError.resultOK, message: nil, data: fileURL.path))
            } catch {
                self.onResult?(Result(code: ResultError.resultOK, message: error.localizedDescription, data: nil))
            }
        } else {
            self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
        }
        self.rootController?.dismiss(animated: true)
        self.onResult = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
        self.rootController?.dismiss(animated: true)
        self.onResult = nil
    }
}
