//
//  APIClientError.swift
//  TestAssignment
//
//  Created by Wonderland on 2021-10-03.
//

enum APIClientError {
    case noHTTPResponse
    case success
    case clientError
    case badRequest
    case unauthorized
    case emailUnverifiedOrBadUserID
    case pathnotFound
    case socialProfileMissingEmail
    case socialProfileConflictingEmail
    case badPasswordOrDuplicateEmail
    case serverError
    case unknown
}
