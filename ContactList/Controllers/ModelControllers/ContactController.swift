//
//  ContactController.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import Foundation
import CloudKit

class ContactController {
    
    
    //MARK: - Properties
    static var shared = ContactController()
    var contacts: [Contact] = []
    private let privateDB = CKContainer.default().privateCloudDatabase
//    private let privateDB = CKContainer.default().publicCloudDatabase
    
    
    
    //MARK: - CRUD iCloud Functions
    
    func createContact(name: String, email: String?, phoneNumber: String?, completion: @escaping (Result<Contact, ContactError>) -> Void ) {
        let contact = Contact(phoneNumber: phoneNumber,
                              name: name,
                              email: email)
        let record = CKRecord(contact: contact)
        
        privateDB.save(record) { record, error in
            if let error = error {
                return completion(.failure(.creationError(error)))
            }
            
            if let newRecord = record, let contact = Contact(ckRecord: newRecord) {
                ContactController.shared.contacts.append(contact)
                ContactController.shared.contacts.sort(by: {$0.name > $1.name})
                return completion(.success(contact))
            } else {
                return completion(.failure(.invalidContactDecodingFromRecord))
            }
            
        }
    }
    
    func fetchPostOperation( completion: @escaping (Result<[Contact], ContactError>) -> Void) {
        print("hi")
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactKeys.typeKey, predicate: predicate)
        var operation = CKQueryOperation(query: query)
        
        var fetchedContacts: [Contact] = []
        
        print("1")
        
        operation.recordMatchedBlock = {(_, result) in
            switch result {
            case .success(let record):
                if let contact = Contact(ckRecord: record) {
                    fetchedContacts.append(contact)
                } else {
                    return completion(.failure(.invalidContactDecodingFromRecord))
                }
            case .failure(let error):
                return completion(.failure(.fetchPostError(error)))
            }
        }
        
        operation.queryResultBlock = {result in
            switch result {
            case .success(let cursor):
                if let cursor = cursor {
                    let nextOperation = CKQueryOperation(cursor: cursor)
                    nextOperation.queryResultBlock = operation.queryResultBlock
                    nextOperation.recordMatchedBlock = operation.recordMatchedBlock
                    nextOperation.qualityOfService = .userInteractive
                    operation = nextOperation
                    
                    self.privateDB.add(operation)
                } else {
                    print(fetchedContacts)
                    return completion(.success(fetchedContacts))
                }
            case .failure(let error):
                return completion(.failure(.fetchPostError(error)))
            }
        }
        print("2")
        self.privateDB.add(operation)
    }
} //End of Class
