//
//  SearchAPIDataSource.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import PromiseKit

protocol SearchAPIDataSource {
    func searchRepositories(query: String, sort: String, page: Int, itemsPerPage: Int) -> Promise<SearchResults<[Repository]>>
}
