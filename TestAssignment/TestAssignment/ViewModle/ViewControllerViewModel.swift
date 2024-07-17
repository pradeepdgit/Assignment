//
//  ViewControllerViewModel.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation

protocol ViewControllerToViewModel {
    var updateUI: (() -> ())? { get set }
}

protocol FetchData {
    func fetchUniversities(apiClient: APIClientSupporter)
}

protocol TableData {
    func fetchUniversity(index: Int) -> University?
    var numberOfSections: Int { get }
    func numberOfRows(section: Int) -> Int
}

class ViewControllerViewModel: ViewControllerToViewModel {
    
    var updateUI: (() -> ())?
    
    var universities: [University]? {
        didSet {
            guard let updateUI = updateUI else {
                return
            }
            updateUI()
        }
    }
    
    var error: (dataError: APIDataError?, clientError: APIClientError?) {
        didSet {
            guard let updateUI = updateUI else {
                return
            }
            updateUI()
        }
    }
}

extension ViewControllerViewModel: TableData {
    var numberOfSections: Int {
        return 1 // Multi sections can be added dynamically by using an array of sections based on data availability
    }

    func numberOfRows(section: Int) -> Int {
        if let universities = universities {
            return universities.count
        }
        return 0
    }
    
    func fetchUniversity(index: Int) -> University? {
        if let universities = universities, index < universities.count {
            return universities[index]
        }
        return nil
    }
}

extension ViewControllerViewModel: FetchData {
    
    func fetchUniversities(apiClient: APIClientSupporter)  {
        let universitiesAPI = UniversitiesAPI(apiClient: apiClient)
        
        Task {
            do {
                let response = try await universitiesAPI.apiClient.loadRequest(api: universitiesAPI)
                if let result = response?.result {
                    switch result {
                        case .success(let universities):
                            DispatchQueue.main.async {
                                self.universities = universities
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.error = (error, nil)
                            }
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.error = (nil, error as? APIClientError)
                }
            }
        }
    }
}
