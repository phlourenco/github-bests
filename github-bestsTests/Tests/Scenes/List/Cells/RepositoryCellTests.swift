////
////  RepositoryCellTests.swift
////  github-bestsTests
////
////  Created by Paulo Lourenço on 04/08/19.
////  Copyright © 2019 Paulo Lourenço. All rights reserved.
////
//
//@testable import github_bests
//import FBSnapshotTestCase
//import Nimble
//
//class RepositoryCellTests: FBSnapshotTestCase {
//
//    var cell: RepositoryCell!
//    var tableView: UITableView!
//    var viewController: UITableViewController!
//    var cellExpectation: XCTestExpectation!
//
//    override func setUp() {
//        super.setUp()
//        setupTableView()
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        cell = nil
//        viewController = nil
//        UIApplication.shared.keyWindow?.rootViewController = nil
//    }
//
//    private func setupTableView() {
//        viewController = UITableViewController()
//        viewController.tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
//        viewController.tableView.delegate = self
//        viewController.tableView.dataSource = self
//        UIApplication.shared.keyWindow?.rootViewController = viewController
//        tableView = viewController.tableView
//    }
//
//    func testRepositoryCell() {
//        cellExpectation = XCTestExpectation(description: "Cell")
//        tableView.reloadData()
//        wait(for: [cellExpectation], timeout: 2.0)
//        cell.configure(repository: Repository(name: "Projeto Top", stargazersCount: 1234, owner: Owner(login: "fulano", avatarUrl: "")))
//        FBSnapshotVerifyView(cell)
//    }
//
//}
//
//extension RepositoryCellTests: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell {
//            self.cell = cell
//            cellExpectation.fulfill()
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//
//}
