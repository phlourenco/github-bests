//
//  SearchAPI.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import PromiseKit

class SearchAPI: SearchAPIDataSource {
    
    func searchRepositories(query: String, sort: String, page: Int, itemsPerPage: Int) -> Promise<SearchResults<[Repository]>> {
        let params: [String: Any] = [
            "q": query,
            "sort": sort,
            "page": page,
            "per_page": itemsPerPage
        ]
        
        return HTTPClient().request(url: "https://api.github.com/search/repositories", method: .get, parameters: params, headers: nil, parseAs: SearchResults<[Repository]>.self, keyDecodingStrategy: .convertFromSnakeCase)
    }
    
}
