//
//  ContactUtil.swift
//  flutter_device
//
//  Created by atlands on 2023/8/2.
//

import Foundation
import Contacts

class ContactUtil {
    private  let contactStore = CNContactStore()
    private var contacts = [Contact]()
    private var onResult: ((Result<[Contact]>) -> Void)? = nil
    
    func getContacts(onResult: @escaping ((Result<[Contact]>) -> Void)){
        self.onResult = onResult
        
        let  status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .authorized {
            res()
        } else {
            contactStore.requestAccess(for: .contacts) { s,_ in
                if s {
                    self.res()
                } else {
                    self.onResult?(Result(code: ResultError.contactPermission, message: "contact permission denied", data: []))
                }
            }
        }
    }
    
    private func res(){
        self.onResult?(Result(code: ResultError.resultOK, message: nil, data: allContacts()))
        self.onResult = nil
    }
    
    private func allContacts() -> [Contact] {
        if !contacts.isEmpty {
            return contacts
        }
        let keys = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
        let request = CNContactFetchRequest(keysToFetch: keys  as [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){ (item,stop) in
                let contact = Contact(
                    displayName: [item.givenName, item.middleName, item.familyName].filter{!$0.isEmpty}.joined(separator: " "),
                    familyName: item.familyName,
                    giveName: item.givenName,
                    phone: item.phoneNumbers.first?.value.stringValue,
                    email: item.emailAddresses.first?.value as? String
                )
                contacts.append(contact)
            }
        } catch {
            print(error.localizedDescription)
        }
        return contacts
    }
}
