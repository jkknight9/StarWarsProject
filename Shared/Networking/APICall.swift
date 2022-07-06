//
//  APICall.swift
//  StarWarsProject
//
//  Created by Jack Knight on 7/5/22.
//

import Foundation

public func APICall(_ httpRequest: HTTPRequest, completion: @escaping (APIResponse) -> Void) {
    guard let request = httpRequest.asURLRequest() else {
        let error = NSError(domain: "com.starwars.networking", code: 500, userInfo: [NSLocalizedDescriptionKey: "Could not create URL request"])
        let response = APIResponse(data: nil, response: nil, error: error)
        completion(response)
        return
    }
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        completion(APIResponse(data: data, response: response, error: error))
    })
    dataTask.resume()
}

public struct HTTPRequest {
   public var method: HTTPMethods
}

public enum HTTPMethods: String {
    case GET
    case POST
}

public struct APIResponse {
    public var data: Data?
    public var response: URLResponse?
    public var error: Error?
}

extension HTTPRequest {
    func asURLRequest() -> URLRequest? {
        let fullPath = NetworkHelper.baseURL
        guard let url = URL(string: fullPath) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}
