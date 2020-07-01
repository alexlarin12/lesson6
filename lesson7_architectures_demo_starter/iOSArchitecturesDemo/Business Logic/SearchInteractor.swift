//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Alamofire

protocol SearchInteractorInput {
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}
// Интерактор: получение данных из сети
final class SearchInteractor: SearchInteractorInput {
    
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        self.searchService.getSongs(forQuery: query, completion: completion)
    }
}
