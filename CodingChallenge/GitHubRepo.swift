//
//  GitHubRepo.swift
//  CodingChallenge
//
//  Created by DzuyAn Nguyen on 10/22/18.
//  Copyright © 2018 SmartThings. All rights reserved.
//

import Foundation

struct GitHubSearchResults: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitHubRepo]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct GitHubRepo: Codable {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case isPrivate = "private"
    }
}
