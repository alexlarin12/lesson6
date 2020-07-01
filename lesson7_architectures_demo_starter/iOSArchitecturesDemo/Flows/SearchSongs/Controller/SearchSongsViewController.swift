//
//  SearchSongsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SearchSongsViewController: UIViewController {

       
        // MARK: - Private Properties
        
        private var searchSongsView: SearchSongsView {
            return self.view as! SearchSongsView
        }
        
        private let searchService = ITunesSearchService()
        internal var searchResults = [ITunesSong]() {
            didSet {
                self.searchSongsView.tableView.isHidden = false
                self.searchSongsView.tableView.reloadData()
                self.searchSongsView.searchBar.resignFirstResponder()
            }
        }
        
        private struct Constants {
            static let reuseIdentifier = "reuseId"
        }
        
        private let presenter: SearchSongsViewOutput
        
        init(presenter: SearchSongsViewOutput) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Lifecycle
        
        override func loadView() {
            super.loadView()
            self.view = SearchSongsView()
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.searchSongsView.searchBar.delegate = self
            self.searchSongsView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
            self.searchSongsView.tableView.delegate = self
            self.searchSongsView.tableView.dataSource = self
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.throbber(show: false)
        }
    }

    //MARK: - UITableViewDataSource
    extension SearchSongsViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
            guard let cell = dequeuedCell as? SongCell else {
                return dequeuedCell
            }
            let song = self.searchResults[indexPath.row]
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            return cell
        }
    }

    //MARK: - UITableViewDelegate
    extension SearchSongsViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let song = searchResults[indexPath.row]
            self.presenter.viewDidSelectSong(song)
        }
    }

    //MARK: - UISearchBarDelegate
    extension SearchSongsViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let query = searchBar.text else {
                searchBar.resignFirstResponder()
                return
            }
            if query.count == 0 {
                searchBar.resignFirstResponder()
                return
            }
            self.presenter.viewDidSearch(with: query)
        }
    }

    extension SearchSongsViewController: SearchSongsViewInput {
        
        func showError(error: Error) {
            let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
        
        func showNoResults() {
            self.searchSongsView.emptyResultView.isHidden = false
            self.searchResults = []
            self.searchSongsView.tableView.reloadData()
        }
        
        func hideNoResults() {
            self.searchSongsView.emptyResultView.isHidden = true
        }
        
        func throbber(show: Bool) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
        
        

}
