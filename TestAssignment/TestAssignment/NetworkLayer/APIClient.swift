import Foundation

let tokenHeader = "Bearer "

protocol APIClientSupporter: HTTPStatusCodeHandling {
    func loadRequest<T: API>(api: T) async throws -> T.ResponseObject?
}

public struct APIClient: APIClientSupporter {
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func loadRequest<T: API>(api: T) async throws -> T.ResponseObject? {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            var request: URLRequest!
            do {
                request = try api.createRequest(api: api)
            } catch {
                continuation.resume(throwing: APIClientError.failedToMakeRequest)
            }
            
            urlSession.dataTask(with: request) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    guard error == nil,
                          let responseData = data else {
                        continuation.resume(throwing: httpStatus(code: httpResponse.statusCode))
                        return
                    }
                    
                    let parsedResponse = T.ResponseObject(responsedata: responseData)
                    continuation.resume(with: .success(parsedResponse))
                    return
                }
                continuation.resume(throwing: APIClientError.unknown)
            }.resume()
        }
    }
}
