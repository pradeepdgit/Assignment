//
//  API.swift
//  TestAssignment
//
//  Created by Wonderland on 2021-10-02.
//

import Foundation
import Alamofire

typealias TAHTTPMethod = HTTPMethod // TA- TestAssignment
typealias TAParameterEncoding = ParameterEncoding
typealias TADataResponse = DataResponse
typealias TADataRequest = DataRequest
typealias TAAFError = AFError
typealias TAHTTPHeaders = HTTPHeaders
typealias TAHTTPHeader = HTTPHeader
typealias TAURLEncoding = URLEncoding

protocol API {
    associatedtype ResponseObject: Response
    var apiClient: APIClientSupporter { get set }
    
    var baseUrl: String { get }
    var finalURL: String { get }
    var method: TAHTTPMethod { get set }
    var parameters: [String: Any] { get set }
    var headers: [String: Any] { get set }
    var paramsAsData: Data? { get set }
        
    func getAPIPath() -> String
}

extension API {
    
    var baseUrl: String { return "" }
//    public var jsonEncodingType: ParameterEncoding { return URLEncoding.httpBody }
    var jsonEncodingType: ParameterEncoding { return JSONEncoding.default }
    
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
        if parameters.isEmpty == false && method == TAHTTPMethod.get {
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
    
    func getHeaders() -> TAHTTPHeaders? {
        let httpsheaders = headers.map { (arg0) -> HTTPHeader in
            return HTTPHeader(name: arg0.key, value: arg0.value as! String)
        }
        
        if httpsheaders.isEmpty {
            return nil
        }
        
        return HTTPHeaders(httpsheaders)
    }
}
