//
//  RepositoryListViewController.swift
//  github-bests
//
//  Created by Paulo Lourenço on 02/08/19.
//  Copyright (c) 2019 Paulo Lourenço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation
import UIKit

protocol RepositoryListDisplayLogic: class, BaseDisplayLogic {
    func displayList()
    func showPaginationLoading()
    func hidePaginationLoading()
}

class RepositoryListViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
            tableView.tableFooterView = UIView()
//            tableView.refreshControl = refreshControl
            tableView.addSubview(refreshControl)
            tableView.accessibilityIdentifier = "tableView"
        }
    }
    
    // MARK: Private properties
    
    private lazy var refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return ref
    }()
    
    // MARK: Public properties
    
    var interactor: RepositoryListBusinessLogic?
    
    // MARK: Object lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RepositoryListInteractor()
        let presenter = RepositoryListPresenter()
        viewController.interactor = interactor
        presenter.viewController = viewController
        interactor.presenter = presenter
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchRepositories(next: false, showLoading: true)
    }
    
    // MARK: View lifecycle
    
    @objc
    private func pullToRefreshAction() {
        interactor?.fetchRepositories(next: false, showLoading: false)
    }
}

extension RepositoryListViewController: RepositoryListDisplayLogic  {
    
    func displayList() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showPaginationLoading() {
        tableView.tableFooterView = LoadingView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }
    
    func hidePaginationLoading() {
        tableView.tableFooterView = UIView()
    }
    
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.repositoryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell, let repository = interactor?.repositoryList[indexPath.row] {
            cell.configure(repository: repository)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor?.fetchMore(indexPath: indexPath)
    }
    
}

