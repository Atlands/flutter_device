//
//  ContactUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//
import ContactsUI

class ContactPicker: NSObject, CNContactPickerDelegate{
    let rootController = UIApplication.shared.delegate?.window??.rootViewController
    private var onResult: ((Result<String?>) -> Void)? = nil
    
    let controller = CNContactPickerViewController()
    
    func picker(onResult:@escaping ((Result<String?>) -> Void)){
        self.onResult = onResult
        
        let  status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .authorized {
            res()
        } else {
            let contactStore = CNContactStore()
            contactStore.requestAccess(for: .contacts) { s,_ in
                if s {
                    self.res()
                } else {
                    self.onResult?(Result(code: ResultError.contactPermission, message: "contact permission denied", data: nil))
                }
            }
        }

    }
    
    func res() {
        if rootController != nil {
            controller.delegate = self
            rootController?.present(controller, animated: true)
        } else {
            self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
            self.onResult = nil
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//        let data = Contact(
//            displayName: [contact.givenName, contact.middleName, contact.familyName].filter{!$0.isEmpty}.joined(separator: " "),
//            phone: contact.phoneNumbers.first(where: { !$0.value.stringValue.trimmingCharacters(in: .whitespaces).isEmpty })?.value.stringValue ?? "")
        
        let map = [
            "other_name": [contact.givenName, contact.middleName, contact.familyName].filter{!$0.isEmpty}.joined(separator: " "),
            "other_mobile": contact.phoneNumbers.first(where: { !$0.value.stringValue.trimmingCharacters(in: .whitespaces).isEmpty })?.value.stringValue ?? ""
        ]
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: getJsonString(from: map)))
        self.onResult = nil
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: nil))
        self.onResult = nil
    }
}
