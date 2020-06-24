//
//  API.swift
//  CodingChallenge
//
//  Created by DzuyAn Nguyen on 10/23/18.
//  Copyright © 2018 SmartThings. All rights reserved.
//

import Foundation
import RxSwift

public enum HttpMethod: String {
    case get, post, put, delete
}

protocol APIRequest {
    var method: HttpMethod { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                             resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

final class APIClient {
    private let baseURL = URL(string: "https://api.github.com/")!
    
    // TODO: Candidates to implement this method body for the response from the API.
    /* func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
    } */
}

