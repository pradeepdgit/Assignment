//
//  ApiEnvironment.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 17/07/24.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        var url = ""
        
        if let subdomain = subdomain() {
            url.append(subdomain)
            url.append(".")
        }
        
        url.append(domain())

        return  url
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "http://universities.hipolabs.com"
        case .staging:
            return "http://universities.hipolabs.com"
        case .production:
            return "http://universities.hipolabs.com"
        }
    }
    
    func subdomain() -> String? {
        switch self {
        case .development, .production, .staging:
            return nil
        }
    }
    
    func route() -> String? {
        return nil
    }
}
