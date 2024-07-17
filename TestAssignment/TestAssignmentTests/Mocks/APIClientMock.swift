//
//  UniversityAPIMock.swift
//  TestAssignmentUITests
//
//  Created by Pradeepkumar on 2021-10-05.
//

@testable import TestAssignment
import XCTest

import Foundation

public struct APIClientMock: APIClientSupporter {
    var jsonFileName: String?
    var status: APIClientError?
    
    func makeRequest<T>(api: T, completion: @escaping (T.ResponseObject?, APIClientError) -> Void) where T : API {
        
        if status != nil {
            //look for all the statuses
            completion(nil, status!)
        }
        
        var statusCode = APIClientError.success

        if let filePath = Bundle.init(for: TestAssignmentTests.self).path(forResource:  jsonFileName, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            completion(T.ResponseObject(responsedata: data as Data), statusCode)
            return
        }
        
        statusCode = APIClientError.badRequest
        completion(nil, statusCode)
    }
}
