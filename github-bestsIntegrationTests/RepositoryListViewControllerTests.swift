////
////  RepositoryListViewControllerTests.swift
////  github-bestsTests
////
////  Created by Paulo Lourenço on 04/08/19.
////  Copyright © 2019 Paulo Lourenço. All rights reserved.
////
//
//import XCTest
//import KIF
//import FBSnapshotTestCase
//import UIKit
////@testable import github_bests
//
//class RepositoryListViewControllerTests: FBSnapshotTestCase {
//    
//    
////    lazy var app: XCUIApplication = XCUIApplication()
//    let stubs = RequestStubs()
////
////    
////    
//    override func setUp() {
//        super.setUp()
////        recordMode = true
//        
//        
////        let repositories = SearchAPIMock().generateRepositories(count: 20)
////        let results = SearchResults<[Repository]>(totalCount: repositories.count, incompleteResults: false, items: repositories)
//        
////        stubs.stubRequest(path: "/search/repositories?page=1&per_page=20&q=language%3Aswift&sort=stars", jsonData:  results.toData() ?? Data() )
//        
//        continueAfterFailure = false
//        UIApplication.
//        let app = XCUIApplication()
//        app.launch()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
////        stubs.server.stop()
//    }
//
////    func testViewController() {
////
////        if let tableView = tester().waitForView(withAccessibilityLabel: "tableView") as? UITableView {
////            tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView)
////            FBSnapshotVerifyView(tableView)
////        }
////    }
//    
//    func testAff() {
//        XCTAssert(1==1)
//    }
//    
//}
