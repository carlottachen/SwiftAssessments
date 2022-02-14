//
//  Contact.swift
//  MyContacts
//
//  Created by Carlotta Chen on 2/11/22.
//

import Foundation
import CloudKit

struct ContactStrings {
    static let contactKey = "Contact"
    fileprivate static let nameKey = "name"
    fileprivate static let phoneNumberKey = "phoneNumber"
    fileprivate static let emailKey = "email"
}

class Contact {
    var name: String
    var phoneNumber: String?
    var email: String?
    var recordID: CKRecord.ID
    
    init(name: String, phoneNumber: String?, email: String?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.recordID = recordID
    }
}

extension Contact {
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactStrings.nameKey] as? String
        else { return nil }
        
        let phoneNumber = ckRecord[ContactStrings.phoneNumberKey] as? String
        let email = ckRecord[ContactStrings.emailKey] as? String
        
        self.init(name: name, phoneNumber: phoneNumber, email: email, recordID: ckRecord.recordID)
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        // initialize a CKRecord of a contact
        self.init(recordType: ContactStrings.contactKey, recordID: contact.recordID)
        self.setValue(contact.name, forKey: ContactStrings.nameKey)
        self.setValue(contact.phoneNumber, forKey: ContactStrings.phoneNumberKey)
        self.setValue(contact.email, forKey: ContactStrings.emailKey)
    }
}
