//
//  ContactUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation
import Contacts

class CAll {
    private  let cmla = CNContactStore()
    private var _all = [KDCONTACT]()
    private var _result: ((BACKBODY<[KDCONTACT]>) -> Void)? = nil
    
    func findAll(onResult: @escaping ((BACKBODY<[KDCONTACT]>) -> Void)){
        self._result = onResult
        
        let  dmls = CNContactStore.authorizationStatus(for: .contacts)
        if dmls == .authorized {
            back()
        } else {
            cmla.requestAccess(for: .contacts) { s,_ in
                if s {
                    self.back()
                } else {
                    self._result?(BACKBODY(code: ResultError.contactPermission, message: "contact permission denied", data: []))
                }
            }
        }
    }
    
    private func back(){
        self._result?(BACKBODY(code: ResultError.resultOK, message: nil, data: ceml()))
        self._result = nil
    }
    
    private func ceml() -> [KDCONTACT] {
        if !_all.isEmpty {
            return _all
        }
        let dmla = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
        let mlade = CNContactFetchRequest(keysToFetch: dmla  as [CNKeyDescriptor])
        do {
            try cmla.enumerateContacts(with: mlade){ (item,stop) in
                let dmale = KDCONTACT(
                    name: [item.givenName, item.middleName, item.familyName].filter{!$0.isEmpty}.joined(separator: " "),
                    lastName: item.familyName,
                    firstName: item.givenName,
                    other_mobile: item.phoneNumbers.first?.value.stringValue,
                    email: item.emailAddresses.first?.value as? String
                )
                _all.append(dmale)
            }
        } catch {
            print(error.localizedDescription)
        }
        return _all
    }
}
