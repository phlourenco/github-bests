//
//  BaseResults.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

struct SearchResults<T: Decodable>: Decodable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: T
}
