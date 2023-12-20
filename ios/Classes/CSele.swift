//
//  ContactUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//
import ContactsUI

class CSele: NSObject, CNContactPickerDelegate{
    let rotCon = UIApplication.shared.delegate?.window??.rootViewController
    private var _result: ((BACKBODY<String?>) -> Void)? = nil
    
    let fdmd = CNContactPickerViewController()
    
    func selecter(onResult:@escaping ((BACKBODY<String?>) -> Void)){
        self._result = onResult
        
        let  dmla = CNContactStore.authorizationStatus(for: .contacts)
        if dmla == .authorized {
            back()
        } else {
            let mldae = CNContactStore()
            mldae.requestAccess(for: .contacts) { s,_ in
                if s {
                    self.back()
                } else {
                    self._result?(BACKBODY(code: ResultError.contactPermission, message: "contact permission denied", data: nil))
                }
            }
        }

    }
    
    func back() {
        if rotCon != nil {
            fdmd.delegate = self
            rotCon?.present(fdmd, animated: true)
        } else {
            self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
            self._result = nil
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//        let data = Contact(
//            name: [contact.givenName, contact.middleName, contact.familyName].filter{!$0.isEmpty}.joined(separator: " "),
//            phone: contact.phoneNumbers.first(where: { !$0.value.stringValue.trimmingCharacters(in: .whitespaces).isEmpty })?.value.stringValue ?? "")
        
        let map = [
            "other_name": [contact.givenName, contact.middleName, contact.familyName].filter{!$0.isEmpty}.joined(separator: " "),
            "other_mobile": contact.phoneNumbers.first(where: { !$0.value.stringValue.trimmingCharacters(in: .whitespaces).isEmpty })?.value.stringValue ?? ""
        ]
        self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: mlea(from: map)))
        self._result = nil
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: nil))
        self._result = nil
    }
}
