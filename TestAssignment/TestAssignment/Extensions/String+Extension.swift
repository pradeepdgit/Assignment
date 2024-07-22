//
//  String+Extension.swift
//  TestAssignmentTests
//
//  Created by Pradeepkumar on 22/07/24.
//

import Foundation 

extension String {
    var asUrl: URL? { URL(string: self) }
}
