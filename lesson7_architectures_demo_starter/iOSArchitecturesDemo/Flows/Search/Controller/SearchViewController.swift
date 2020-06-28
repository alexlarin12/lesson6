//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    internal var searchResults = [ITunesApp]() {
        didSet {
            self.searchView.tableView.isHidden = false
            self.searchView.tableView.reloadData()
            self.searchView.searchBar.resignFirstResponder()
        }
    }
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    private let presenter: SearchViewOutput
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    // MARK: - Private
    
//    internal func throbber(show: Bool) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = show
//    }
//
//    internal func showError(error: Error) {
//        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(actionOk)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    internal func showNoResults() {
//        self.searchView.emptyResultView.isHidden = false
//    }
//
//    internal func hideNoResults() {
//        self.searchView.emptyResultView.isHidden = true
//    }
    
//    private func requestApps(with query: String) {
//        self.throbber(show: true)
//        self.searchResults = []
//        self.searchView.tableView.reloadData()
//
//        self.searchService.getApps(forQuery: query) { [weak self] result in
//            guard let self = self else { return }
//            self.throbber(show: false)
//            result
//                .withValue { apps in
//                    guard !apps.isEmpty else {
//                        self.searchResults = []
//                        self.showNoResults()
//                        return
//                    }
//                    self.hideNoResults()
//                    self.searchResults = apps
//
//                    self.searchView.tableView.isHidden = false
//                    self.searchView.tableView.reloadData()
//
//                    self.searchView.searchBar.resignFirstResponder()
//                }
//                .withError {
//                    self.showError(error: $0)
//                }
//        }
//    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        let app = self.searchResults[indexPath.row]
        let cellModel = AppCellModelFactory.cellModel(from: app)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = searchResults[indexPath.row]
        self.presenter.viewDidSelectApp(app)
//        let appDetaillViewController = AppDetailViewController(app:app)
////        appDetaillViewController.app = app
//        navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        //self.requestApps(with: query)
        self.presenter.viewDidSearch(with: query)
    }
}

extension SearchViewController: SearchViewInput {
    
//        var searchResults: [ITunesApp] { get set }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
        self.searchResults = []
        self.searchView.tableView.reloadData()
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    
}

//let parent = UIViewController()
//let child = UIViewController()
//
//parent.view.addSubview(child.view)
//parent.addChild(child)
//child.didMove(toParent: parent)
