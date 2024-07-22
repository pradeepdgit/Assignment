//
//  API.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-02.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct APIHeader {
    static var kContentType = "Content-Type"
    static var contentTypeValue = "application/json"
}

protocol API {
    associatedtype ResponseObject: Response
    var apiClient: APIClientSupporter { get set }
    
    var baseUrl: String { get }
    var finalURL: String { get }
    var method: HTTPMethod { get set }
    var parameters: [String: Any] { get set }
    var headers: [String: String] { get set }
    var paramsAsData: Data? { get set }
        
    func getAPIPath() -> String
}

extension API {
    
    var baseUrl: String { return environment.baseURL() }
        
    var paramsAsData: Data? {
        do {
            let paramData = try JSONSerialization.data(withJSONObject: parameters)
            return paramData
        } catch let error {
            print("failed to convert dictionary to Data for request \(String(describing: self)) error = \(error.localizedDescription)")
        }
        
        return nil
    }
    
    var finalURL: String {
        var paramStr: String? = ""
        if parameters.isEmpty == false && method == HTTPMethod.get {
            paramStr = "?"
            let keys = parameters.keys
            
            for (index, key) in keys.enumerated() {
                guard let aparamStr = paramStr
                    else { return "" }
                guard let keyVal: String = parameters[key] as? String
                    else { return "" }
                paramStr = aparamStr + key + "=" + keyVal +  ((index < keys.count-1) ? "&" : "")
            }
            
            paramStr = paramStr?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        }
        return baseUrl + getAPIPath() + paramStr!
    }
    
    func createRequest<T: API>(api: T) throws -> URLRequest? {
        guard let url = api.finalURL.asUrl else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.httpBody = api.method == .post ? api.paramsAsData : nil
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
