//
//  ViewControllerTests.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 05/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import FBSnapshotTestCase
import Nimble
@testable import github_bests

class RepositoryListViewControllerTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFlow() {
        if let tableView = tester().waitForView(withAccessibilityLabel: "tableView") as? UITableView {
            tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView)
            sleep(5)
            FBSnapshotVerifyView(tableView)
        }
    }
    
}
