//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Bondarenko on 25.06.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {
    
    // MARK: - Properties
    
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    //MARK: - Init
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()        // Do any additional setup after loading the view.
    }
    
    private func fillData() {
        self.downLoadImage()
        self.appDetailHeaderView.titleLabel.text = app.appName
        self.appDetailHeaderView.subTitleLabel.text = app.company
        self.appDetailHeaderView.raitingLabel.text = app.averageRating >>- {
            "\($0)"
        }
    }
    
    private func downLoadImage() {
        guard let url = self.app.iconUrl else { return }
        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
            self?.appDetailHeaderView.imageView.image = image
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
