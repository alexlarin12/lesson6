//
//  SearchSongsViewIntarface.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongsViewInput: class {
    
    var searchResults: [ITunesSong] { get set }
    
    func showError(error: Error)
    
    func showNoResults()
    
    func hideNoResults()
    
    func throbber(show: Bool)
}

protocol SearchSongsViewOutput: class {
    
    func viewDidSearch(with query: String)
    
    func viewDidSelectSong(_ song: ITunesSong)
    
}
