//
//  Repository.swift
//  github-bests
//
//  Created by Paulo Lourenço on 02/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    var name: String
    var stargazersCount: Int
    var owner: Owner
}

struct Owner: Decodable {
    var login: String
    var avatarUrl: String
}
