//
//  SearchAPIMock.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
@testable import github_bests
@testable import PromiseKit

class SearchAPIMock: SearchAPIDataSource {
    
    func generateRepositories(count: Int) -> [Repository] {
        var repositories = [Repository]()
        for i in 0..<count {
            repositories.append(Repository(name: "Repositório #\(i)", stargazersCount: 99999, owner: Owner(login: "fulano", avatarUrl: "https://assets.b9.com.br/wp-content/uploads/2014/05/google-novo-logo.jpg")))
        }
        return repositories
    }
    
    func searchRepositories(query: String, sort: String, page: Int, itemsPerPage: Int) -> Promise<SearchResults<[Repository]>> {
        let repositories = generateRepositories(count: itemsPerPage)
        let results = SearchResults<[Repository]>(totalCount: repositories.count, incompleteResults: false, items: repositories)
        return .value(results)
    }
    
}
