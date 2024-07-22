//
//  ViewControllerSnapshot.swift
//  TestAssignmentTests
//
//  Created by Pradeepkumar on 22/07/24.
//

import SnapshotTesting
import XCTest
@testable import TestAssignment

class MyViewControllerTests: XCTestCase {
    
    var viewModel: ViewControllerViewModel = ViewControllerViewModel()
    
  func testUniversitiesList() {
      
      viewModel.fetchUniversities(
          apiClient: APIClientMock(
              jsonFileName: "UniversitiesAPI",
              status: APIClientError.success
          )
      )
      let viewController = ViewController.create(with: viewModel)
      testAfter(1.0, testCase: {
          assertSnapshot(of: viewController, as: .image(on: .iPhone13(.portrait)))
      })
  }
    
    func testUniversitiesListWithFalseUrl() {
        
        viewModel.fetchUniversities(
            apiClient: APIClientMock(
                jsonFileName: "UniversitiesAPI3",
                status: APIClientError.success
            )
        )
        let viewController = ViewController.create(with: viewModel)
        testAfter(2.0, testCase: {
            assertSnapshot(of: viewController, as: .image(on: .iPhone13(.portrait)))
        })
    }
}

