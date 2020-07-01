//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    
    func openDetails(for song: ITunesSong)
    
    func openSongInITunes(_ song: ITunesSong)
}

final class SearchRouter: SearchRouterInput {
    
    weak var viewController: UIViewController?
    // метод открытия экрана деталей приложения:
    func openDetails(for song: ITunesSong) {
        let songDetailViewController = SongDetailViewController(song: song)
        
        self.viewController?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
    // метод открытия приложения в нативном AppStore
    func openSongInITunes(_ song: ITunesSong) {
        guard let urlString = song.artistViewUrl, let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}
