//
//  ViewControllerToViewModelTests.swift
//  ViewControllerToViewModelTests
//
//  Created by Wonderland on 2021-10-04.
//

import XCTest
@testable import TestAssignment

class ViewControllerToViewModelTests: XCTestCase {
    
    var viewModel: ViewControllerViewModel? = ViewControllerViewModel()
    
    func testfetchUniversities() {
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI1", status: nil))
        XCTAssertEqual(viewModel?.error.dataError, APIDataError.parsingError)
        
        let numberOfRows = viewModel?.numberOfRows(section: 0)
        XCTAssertEqual(numberOfRows, 0)
        viewModel?.universities = nil

        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI2", status: nil))
        XCTAssertEqual(viewModel?.error.clientError, APIClientError.badRequest)
        viewModel?.universities = nil
                
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI", status: APIClientError.badRequest))
        XCTAssertEqual(viewModel?.error.clientError, APIClientError.badRequest)
        viewModel?.universities = nil
    }
    
    func testFetchUniversity() {
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI", status: APIClientError.success))
        XCTAssertNotNil(viewModel?.universities)
        
        let numberOfRows = viewModel?.numberOfRows(section: 0)
        XCTAssertEqual(numberOfRows, 344)

        var index = 343
        var university = viewModel?.fetchUniversity(index: index)
        XCTAssertNotNil(university)
        XCTAssertEqual(university?.name, "Middlesbrough College")
        XCTAssertEqual(university?.country, "United Kingdom")
        
        index = 344
        university = viewModel?.fetchUniversity(index: index)
        XCTAssertNil(university)
    }
    
    func testUpdateUI() {
        viewModel?.updateUI = { [weak self] in
            let index = 343
            let university = self?.viewModel?.fetchUniversity(index: index)
            XCTAssertNotNil(university)
            XCTAssertEqual(university?.name, "Middlesbrough College")
            XCTAssertEqual(university?.country, "United Kingdom")
        }
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI", status: nil))
    }
    
    func testUpdateUI1() {
        viewModel?.updateUI = { [weak self] in
            let index = 343
            let university = self?.viewModel?.fetchUniversity(index: index)
            XCTAssertNil(university)
        }
        viewModel?.universities = nil;
    }
    
    func testUpdateUIShowDataError() {
        viewModel?.updateUI = { [weak self] in
            XCTAssertEqual(self?.viewModel?.error.dataError, APIDataError.parsingError)
        }
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI1", status: nil))
    }
    
    func testUpdateUIshowClientError() {
        viewModel?.updateUI = { [weak self] in
            XCTAssertEqual(self?.viewModel?.error.clientError, APIClientError.badRequest)
        }
        viewModel?.fetchUniversities(apiClient: APIClientMock(jsonFileName: "UniversitiesAPI2", status: nil))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.viewModel = nil
    }
}
