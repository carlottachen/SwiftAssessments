//
//  ContactController.swift
//  MyContacts
//
//  Created by Carlotta Chen on 2/11/22.
//

import UIKit
import CloudKit

class ContactController {
    
    static let shared = ContactController()
    var contacts: [Contact] = [] // contacts is our array of Contact objects
    let publicDB = CKContainer.default().publicCloudDatabase // access publicCloudDB
    
    func saveContact(with name: String, phoneNumber: String?, email: String?, completion: @escaping (Bool) -> Void) {
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        let contactRecord = CKRecord(contact: newContact)
        //save to cloud
        publicDB.save(contactRecord) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            
            guard let record = record,
                  let savedRecord = Contact(ckRecord: record)
            else { return completion(false) }
            
            // append to our array if everything works
            self.contacts.insert(savedRecord, at: 0)
            completion(true)
        }
    }
    
    func fetchContacts(completion: @escaping (Result<[Contact]?, ContactError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactStrings.contactKey, predicate: predicate)
        var operation = CKQueryOperation(query: query)
        var fetchedContacts: [Contact] = []
        
        // add to fetchedContacts when record match is found
        operation.recordMatchedBlock = { (_, result) in
            switch result {
            case .success(let record):
                guard let fetchedContact = Contact(ckRecord: record) else {
                    return (completion(.failure(.noContact)))
                }
                fetchedContacts.append(fetchedContact)
            case .failure(let error):
                return (completion(.failure(.ckError(error))))
            }
        }
        
        // look for records that match query
        operation.queryResultBlock = { result in
            switch result {
            case .success(let cursor):
                if let cursor = cursor {
                    let nextOperation = CKQueryOperation(cursor: cursor)
                    nextOperation.queryResultBlock = operation.queryResultBlock
                    nextOperation.recordMatchedBlock = operation.recordMatchedBlock
                    operation = nextOperation
                    self.publicDB.add(nextOperation)
                } else {
                    // updated contacts array with our new fetched contacts array
                    // self.contacts = fetchedContacts
                    return completion(.success(fetchedContacts))
                }
            case .failure(let error):
                return completion(.failure(.ckError(error)))
            }
        }
        publicDB.add(operation)
    }
    
    func update(contact: Contact, completion: @escaping (Result<Contact, ContactError>) -> Void) {
        let record = CKRecord(contact: contact)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record])
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success():
                print("update")
                return completion(.success(contact))
            case .failure(let error):
                print("not update")
                return completion(.failure(.ckError(error)))
            }
        }
        publicDB.add(operation)
    }
    
    func delete(_ contact: Contact, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation(recordIDsToDelete: [contact.recordID])
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success():
                print("Record removed")
                return completion(true)
            case .failure(_):
                print("Issue attempting to delete record")
                return completion(false)
            }
        }
        publicDB.add(operation)
    }
}
