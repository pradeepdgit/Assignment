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
    var baseUrl: String = "http://universities.hipolabs.com"
    typealias ResponseObject = UniversitiesAPIResponse
    weak var dataRequest: TADataRequest?
    
    var headers: [String: Any] = ["Content-Type": "application/json"]
    var method: TAHTTPMethod  = .get
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
