//
//  StubManager.swift
//  github-bests
//
//  Created by Paulo Lourenço on 05/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import OHHTTPStubs

class StubManager {
    
    static let shared = StubManager()
    
    func stubRequests(withDelay delay: TimeInterval) {
        stub(condition: isHost("api.github.com") && containsQueryParams(["page": "1"])) { (req) -> OHHTTPStubsResponse in
            let repositories = SearchAPIMock().generateRepositories(count: 20)
            let results = SearchResults<[Repository]>(totalCount: repositories.count, incompleteResults: false, items: repositories)
            return OHHTTPStubsResponse(data: results.toData() ?? Data(), statusCode: 200, headers: nil).responseTime(3.0)
        }
        
        stub(condition: isHost("api.github.com") && containsQueryParams(["page": "2"])) { (req) -> OHHTTPStubsResponse in
            let repositories = SearchAPIMock().generateRepositories(count: 20, startWith: 20)
            let results = SearchResults<[Repository]>(totalCount: repositories.count, incompleteResults: false, items: repositories)
            return OHHTTPStubsResponse(data: results.toData() ?? Data(), statusCode: 200, headers: nil).responseTime(3.0)
        }
        
        stub(condition: isHost("localhost")) { (req) -> OHHTTPStubsResponse in
            let img = UIImage(named: "github_logo_placeholder")
            return OHHTTPStubsResponse(data: img?.pngData() ?? Data(), statusCode: 200, headers: nil).responseTime(delay)
        }
    }
    
}
