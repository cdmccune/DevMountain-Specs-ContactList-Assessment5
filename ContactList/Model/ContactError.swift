//
//  ContactError.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import Foundation

enum ContactError: LocalizedError {
    case invalidContactDecodingFromRecord
    case creationError(Error)
    case fetchContactError(Error)
    case ckError(Error)
    case deletionError(Error)
    case modifyError(Error)
    
    
    var localizedDescription: String {
        switch self {
        case .invalidContactDecodingFromRecord:
            return "Contact could not be decoded from record"
        case .creationError(let error):
            return "Error saving new contact: \(error)"
        case .fetchContactError(let error):
            return "Error fetching contact: \(error)"
        case .ckError(let error):
            return "CKError: \(error)"
        case .deletionError(let error):
            return "Error deleting record: \(error)"
        case .modifyError(let error):
            return "Error modifying record: \(error)"
        }
    }
}
