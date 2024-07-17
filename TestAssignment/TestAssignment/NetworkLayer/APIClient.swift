import Alamofire
import Foundation

let tokenHeader = "Bearer "

protocol APIClientSupporter: HTTPStatusCodeHandling {
    func makeRequest<T: API>(api: T, completion: @escaping (_ response: T.ResponseObject?, _ statusCode: APIClientError) -> Void)
}


public struct APIClient: APIClientSupporter {
    func makeRequest<T>(api: T, completion: @escaping (T.ResponseObject?, APIClientError) -> Void) where T : API {
        
        AF.request(api.finalURL,
                   method: api.method,
                   parameters: api.method == .get ? nil: api.parameters,
                   encoding: api.jsonEncodingType ,
                   headers: api.getHeaders(),
                   interceptor: nil,
                   requestModifier: nil).responseJSON { (response: DataResponse<Any, TAAFError>) in
            switch response.result {
                case .success:
                    let statusCode = (response.response?.statusCode)!
                    
                    if self.isSuccessStatus(code: statusCode) {
                        //Parse the response and send it to respective controller or class using completion block
                        guard let responseData = response.data else {
                            completion(nil, self.httpStatus(code: statusCode))
                            return
                        }
                        let lresponse = T.ResponseObject(responsedata: responseData)
                        completion(lresponse,  self.httpStatus(code: statusCode))
                    } else {
                        completion(nil, self.httpStatus(code: statusCode))
                    }
                case .failure:
                    completion(nil, self.httpStatus(code: response.response?.statusCode ?? 0))
            }
        }
    }
}
