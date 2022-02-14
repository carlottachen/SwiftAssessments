//
//  ContactError.swift
//  MyContacts
//
//  Created by Carlotta Chen on 2/11/22.
//

import Foundation

enum ContactError: LocalizedError {
    
    case ckError(Error)
    case noRecord
    case noContact
    
    var localizedDescription: String {
        switch self {
        case .ckError(let error):
            return "There was an error returned from cloudkit. Error: \(error)"
        case .noRecord:
            return "No record was returned from cloudkit"
        case .noContact:
            return "The contact was not found"
        }
    }
}
