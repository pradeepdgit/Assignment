//
//  HTTPStatusCodeHandling.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 16/07/24.
//

protocol HTTPStatusCodeHandling {
    func isSuccessStatus(code: Int) -> Bool
    func httpStatus(code: Int) -> APIClientError
}

extension HTTPStatusCodeHandling {
    
    func isSuccessStatus(code: Int) -> Bool {
        
        switch code {
            case 200: return true
            default: return false
        }
    }
    
    func httpStatus(code: Int) -> APIClientError {
        
        switch code {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 500: return .serverError
            case 502: return .badGateway
            case 503: return .serviceUnavailable
            default: return .unknown
        }
    }
}
