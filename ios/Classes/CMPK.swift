//
//  CameraPicker.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation
import AVFoundation


struct FJDAL {
    let wamld: Double?
    let haldcl: Double?
    let qualmd: CGFloat
    let fnoda: Bool
}

class CMPK: NSObject, UINavigationControllerDelegate {
    let rotClo = UIApplication.shared.delegate?.window??.rootViewController
    let _dame = UIImagePickerController()
    
    private var _result: ((BACKBODY<String?>) -> Void)? = nil
    private var _option: FJDAL = FJDAL(wamld: nil, haldcl: nil, qualmd: 100, fnoda: false)
    
    func selecter(option: FJDAL, onResult: @escaping ((BACKBODY<String?>) -> Void)){
        self._option = option
        self._result = onResult
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            photoTake()
        }else{
            AVCaptureDevice.requestAccess(for: .video){ granted in
                if granted {
                    self.photoTake()
                } else {
                    self._result?(BACKBODY(
                        code: ResultError.cameraPermission,
                        message: "camera permission denied",
                        data: nil
                    ))
                    self._result = nil
                }
            }
        }
    }
    
    private func photoTake(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            self._result?(BACKBODY(code: ResultError.cameraNo, message: "the device does not have a camera", data: nil))
            self._result = nil
            return
        }
        DispatchQueue.main.async { [self] in
            _dame.delegate = self
            _dame.sourceType = .camera
            if _option.fnoda {
                _dame.cameraDevice = .front
            }
        
            _dame.allowsEditing = false
            if rotClo != nil {
                rotClo?.present(_dame, animated: true)
            } else {
                self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
                self._result = nil
            }
        }
    }
}

extension CMPK: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if
            let mkdal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ,
            let damk = mkdal.jpegData(compressionQuality: _option.qualmd / 100.0),
            let daml = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first{
            do {
                let mkls = "\(Date().timeIntervalSince1970).jpeg"
                let oldak = daml.appendingPathComponent(mkls)
                try damk.write(to: oldak)
                self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: oldak.path))
            } catch {
                self._result?(BACKBODY(code: ResultError.resultOK, message: error.localizedDescription, data: nil))
            }
        } else {
            self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
        }
        self.rotClo?.dismiss(animated: true)
        self._result = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
        self.rotClo?.dismiss(animated: true)
        self._result = nil
    }
}
