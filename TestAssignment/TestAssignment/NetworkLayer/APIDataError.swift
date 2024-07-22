//
//  APIDataError.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation

enum APIDataError: Error {
    case parsingError
}

extension APIDataError: LocalizedError {
    
    var dataErrorDescription: String? {
        switch self {
        case .parsingError:
            return NSLocalizedString("Response is not parsable", comment: "Invalid University model")
        }
    }
}
