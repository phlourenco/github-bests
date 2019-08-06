//
//  ViewControllerTests.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 05/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import FBSnapshotTestCase
@testable import github_bests

class RepositoryListViewControllerTests: FBSnapshotTestCase {
    
    func testViewControllerFlow() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController, let rootView = viewController.view else {
            XCTFail("ViewController not found")
            return
        }
        
        guard let tableView = tester().waitForView(withAccessibilityIdentifier: "tableView") as? UITableView else {
            XCTFail("TableView not found")
            return
        }
        
        tester().waitForView(withAccessibilityIdentifier: "ScreenLoadingView")
        
        FBSnapshotVerifyView(rootView, identifier: "first_loading")
        tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView)
        FBSnapshotVerifyView(rootView, identifier: "first_page")

        tester().pullToRefreshView(withAccessibilityIdentifier: "tableView", pullDownDuration: .inAboutAHalfSecond)
        
        tester().waitForAnimationsToFinish()
        
        FBSnapshotVerifyView(rootView, identifier: "pull_to_refresh")
        
        tableView.scrollToLastRow(inSection: 0, animated: false)
        tester().swipeView(withAccessibilityIdentifier: "tableView", in: .up)
        
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")

        FBSnapshotVerifyView(rootView, identifier: "infinity_loading")
        
        tester().waitForAbsenceOfView(withAccessibilityIdentifier: "LoadingView")
        tableView.scrollToLastRow(inSection: 0, animated: false)
        
        FBSnapshotVerifyView(rootView, identifier: "second_page", overallTolerance: 0.001)
    }
    
}
