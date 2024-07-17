//
//  Universities.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation

struct University: Decodable {
    let name, country: String
    let stateProvince: String?

    enum CodingKeys: String, CodingKey {
        case name, country
        case stateProvince = "state-province"
    }
}
