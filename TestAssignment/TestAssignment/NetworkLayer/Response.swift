//
//  Response.swift
//  TestAssignment
//
//  Created by Wonderland on 2021-10-03.
//

import Foundation

protocol Response: HTTPStatusCodeHandling {
    init(responsedata: Data)
}
