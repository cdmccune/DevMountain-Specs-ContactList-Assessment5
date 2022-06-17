//
//  Contact.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import Foundation
import CloudKit


class ContactKeys {
    static var typeKey = "Contact"
    static var nameKey = "name"
    static var phoneNumberKey = "phoneNumber"
    static var emailKey = "email"
}

class Contact {
    var name: String
    var phoneNumber: String?
    var email: String?
    
    init (phoneNumber: String?, name: String, email: String?) {
        self.email = email
        self.phoneNumber = phoneNumber
        self.name = name
    }
}

extension Contact {
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactKeys.nameKey] as? String else {return nil}
        let phoneNumber = ckRecord[ContactKeys.phoneNumberKey] as? String
        let email = ckRecord[ContactKeys.emailKey] as? String
        
        self.init(phoneNumber: phoneNumber, name: name, email: email)
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactKeys.typeKey)
        
        var recordKVP: [String : Any] = [ContactKeys.nameKey : contact.name]
        
        if let email = contact.email {
            recordKVP[ContactKeys.emailKey] = email
        }
        if let phoneNumber = contact.phoneNumber {
            recordKVP[ContactKeys.phoneNumberKey] = phoneNumber
        }
        self.setValuesForKeys(recordKVP)
    }
}
