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
        
        
//        var baseURL: String {
//            get {
//                if ProcessInfo.processInfo.arguments.contains("TESTING") {
//                    return "http://localhost:8080"
//                } else {
//                    return "https://api.github.com"
//                }
//            }
//        }
        var baseURL = "https://api.github.com"
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            baseURL = "http://localhost:8080"
        }
        
        
        return HTTPClient().request(url: "\(baseURL)/search/repositories", method: .get, parameters: params, headers: nil, parseAs: SearchResults<[Repository]>.self, keyDecodingStrategy: .convertFromSnakeCase)
    }
    
}
