//
//  SearchSongsModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

final class SearchSongsModuleBuilder {
    static func build() -> (UIViewController & SearchSongsViewInput) {
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = SearchSongsPresenter(interactor: interactor, router: router)
        let viewController = SearchSongsViewController(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        return viewController
    }
}
