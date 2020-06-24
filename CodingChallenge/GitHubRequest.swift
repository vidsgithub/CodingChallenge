//
//  GitHubRequest.swift
//  CodingChallenge
//
//  Created by DzuyAn Nguyen on 10/23/18.
//  Copyright © 2018 SmartThings. All rights reserved.
//

import Foundation

class GitHubRequest: APIRequest {
    var method = HttpMethod.get
    var path = "search/repositories"
    var parameters = [String: String]()
    
    init(name: String) {
        parameters["q"] = name
        parameters["sort"] = "stars"
        parameters["order"] = "desc"
    }
}
