//
//  UniversityAPIMock.swift
//  TestAssignmentUITests
//
//  Created by Pradeepkumar on 2021-10-05.
//
import XCTest
@testable import TestAssignment

public struct APIClientMock: APIClientSupporter {
    
    var jsonFileName: String?
    var status: APIClientError?
    
    public func loadRequest<T>(api: T) async throws -> T.ResponseObject? where T : API {

        if let filePath = Bundle.init(for: TestAssignmentTests.self).path(forResource: jsonFileName, ofType: "json"),
           let data = NSData(contentsOfFile: filePath) {
            return T.ResponseObject(responsedata: data as Data)
        }
        
        throw APIClientError.badRequest
    }
}
