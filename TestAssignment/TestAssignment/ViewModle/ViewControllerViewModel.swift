//
//  ViewControllerViewModel.swift
//  TestAssignment
//
//  Created by Wonderland on 2021-10-03.
//

import Foundation

protocol ViewControllerToViewModel {
    var updateUI: (() -> ())? { get set }
    func fetchUniversities(apiClient: APIClientSupporter)
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
    
    var numberOfSections: Int {
        return 1 // Multi sections can be added dynamically by using an array of sections based on data availability
    }

    func numberOfRows(section: Int) -> Int {
        if let universities = universities {
            return universities.count
        }
        return 0
    }
        
    func fetchUniversities(apiClient: APIClientSupporter)  {
        let universitiesAPI = UniversitiesAPI(apiClient: apiClient)
        universitiesAPI.apiClient.makeRequest(api: universitiesAPI, completion: {[weak self] (response, status) in
            
            if response != nil {
                switch response!.result {
                case .success(let universities):
                    self?.universities = universities
                case .failure(let error):
                    self?.error = (error, nil)
                }
            } else {
                //TODO: APIClient error
                self?.error = (nil, status)
            }
        })
    }
    
    func fetchUniversity(index: Int) -> University? {
        
        if let universities = universities, index < universities.count {
            return universities[index]
        }
        
        return nil
    }
}
