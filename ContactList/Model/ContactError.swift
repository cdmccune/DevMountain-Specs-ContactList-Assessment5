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
    case fetchPostError(Error)
    case ckError(Error)
    case deletionError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidContactDecodingFromRecord:
            return "Contact could not be decoded from record"
        case .creationError(let error):
            return "Error saving new contact: \(error)"
        case .fetchPostError(let error):
            return "Error fetching posts \(error)"
        case .ckError(let error):
            return "CKError: \(error)"
        case .deletionError(let error):
            return "Error deleting record \(error)"
        }
    }
}
