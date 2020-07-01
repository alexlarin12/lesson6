//
//  SearchViewInterface.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Bondarenko on 25.06.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchViewInput: class {
    
    var searchResults: [ITunesApp] { get set }
    
    func showError(error: Error)
    
    func showNoResults()
    
    func hideNoResults()
    
    func throbber(show: Bool)
}

protocol SearchViewOutput: class {
    
    func viewDidSearch(with query: String)
    
    func viewDidSelectApp(_ app: ITunesApp)
    
}
