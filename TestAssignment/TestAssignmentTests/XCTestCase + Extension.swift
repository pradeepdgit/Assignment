//
//  XCTestCase+Extension.swift
//  TestAssignmentTests
//
//  Created by Pradeepkumar on 22/07/24.
//

import XCTest

extension XCTestCase {
 
    func testAfter(_ interval: TimeInterval, testCase: @escaping () -> Void) {
        let alertExpectation = XCTestExpectation(description: "wait for action To be executed")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval - 0.3, execute: {
            testCase()
            alertExpectation.fulfill()
        })
        wait(for: [alertExpectation], timeout: interval)
    }
}
