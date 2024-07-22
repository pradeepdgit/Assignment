//
//  APIClientError.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

enum APIClientError: Error {
    case success
    case failedToMakeRequest
    case badRequest
    case unauthorized
    case badGateway
    case serverError
    case serviceUnavailable
    case unknown
}
