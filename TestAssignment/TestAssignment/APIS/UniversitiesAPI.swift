//
//  UniversitiesAPI.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation

class UniversitiesAPI: API {
    
    var apiClient: APIClientSupporter
    var paramsAsData: Data?
    typealias ResponseObject = UniversitiesAPIResponse
    
    var headers: [String: String] = ["Content-Type": "application/json"]
    var method: HTTPMethod  = .get
    var parameters: [String: Any] = ["country": "United+Kingdom"]

    init(apiClient: APIClientSupporter) {
        self.apiClient = apiClient
    }
    
    func getAPIPath() -> String {
        return "/search"
    }
}

// MARK: - response processing
extension UniversitiesAPI {
    struct UniversitiesAPIResponse: Response {
        var result: Result<[University], APIDataError>
        
        init(responsedata: Data) {
            do {
                let universities = try JSONDecoder().decode([University].self, from: responsedata)
                result = .success(universities)
            } catch _ {
                result = .failure(APIDataError.parsingError)
            }
        }
    }
}
