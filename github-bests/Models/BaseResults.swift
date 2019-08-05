//
//  BaseResults.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

public struct SearchResults<T: Codable>: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: T
}
