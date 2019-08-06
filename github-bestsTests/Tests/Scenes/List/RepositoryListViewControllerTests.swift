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
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func testViewControllerFlow() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController as? RepositoryListViewController, let rootView = viewController.view else {
            XCTFail("ViewController not found")
            return
        }
        
        guard let tableView = tester().waitForView(withAccessibilityIdentifier: "tableView") as? UITableView else {
            XCTFail("TableView not found")
            return
        }
        
        //Verifica loading de tela cheia
        tester().waitForView(withAccessibilityIdentifier: "ScreenLoadingView")
        FBSnapshotVerifyView(rootView, identifier: "first_loading", suffixes: NSOrderedSet(array: [UIDevice.current.model]))
        
        //Verifica celula
        if let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView) as? RepositoryCell {
            FBSnapshotVerifyView(cell, identifier: "repository_cell", suffixes: NSOrderedSet(array: [UIDevice.current.model]))
        }
        
        //Verifica tela toda, com a lista carregada
        FBSnapshotVerifyView(rootView, identifier: "first_page", suffixes: NSOrderedSet(array: [UIDevice.current.model]))

        //Verifica tela toda, com o loading do pull-to-refresh carregando
        tester().pullToRefreshView(withAccessibilityIdentifier: "tableView", pullDownDuration: .inAboutAHalfSecond)
        tester().waitForAnimationsToFinish()
        FBSnapshotVerifyView(rootView, identifier: "pull_to_refresh", suffixes: NSOrderedSet(array: [UIDevice.current.model]))
        
        //Verifica view do loading infinito
        tableView.scrollToLastRow(inSection: 0, animated: false)
        tester().swipeView(withAccessibilityIdentifier: "tableView", in: .up)
        tester().waitForAnimationsToFinish()
        if let infinityLoadingView = tester().waitForView(withAccessibilityIdentifier: "LoadingView") {
            FBSnapshotVerifyView(infinityLoadingView, identifier: "infinity_loading_view", suffixes: NSOrderedSet(array: [UIDevice.current.model]))
        }
        
        //Verifica tela toda, com loading infinito
        FBSnapshotVerifyView(rootView, identifier: "infinity_loading", suffixes: NSOrderedSet(array: [UIDevice.current.model]))
        
        //Verifica tela toda, com a lista carregada na segunda pagina
        tester().waitForAbsenceOfView(withAccessibilityIdentifier: "LoadingView")
        tableView.scrollToLastRow(inSection: 0, animated: false)
        FBSnapshotVerifyView(rootView, identifier: "second_page", suffixes: NSOrderedSet(array: [UIDevice.current.model]), overallTolerance: 0.001)
    }
    
}
