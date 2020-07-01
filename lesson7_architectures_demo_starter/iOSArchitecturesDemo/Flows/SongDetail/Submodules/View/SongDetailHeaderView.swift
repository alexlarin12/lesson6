//
//  SongDetailHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 01.07.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongDetailHeaderView: UIView {

    // MARK: - Subviews
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    } ()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    } ()

    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    } ()
    
    private(set) lazy var openButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Воспроизвести", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        return button
    } ()
    
    private(set) lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    } ()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.openButton)
        self.addSubview(self.collectionNameLabel)
        
        NSLayoutConstraint.activate([ self.imageView.topAnchor.constraint(equalTo:
        self.safeAreaLayoutGuide.topAnchor, constant: 12.0), self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor,
        constant: 16.0),
        self.imageView.widthAnchor.constraint(equalToConstant: 120.0), self.imageView.heightAnchor.constraint(equalToConstant: 120.0),
        self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
        self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
        self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
        self.subTitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
        self.subTitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
        self.openButton.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
        self.openButton.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor),
        self.openButton.widthAnchor.constraint(equalToConstant: 120.0), self.openButton.heightAnchor.constraint(equalToConstant: 32.0),
        self.collectionNameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 24.0),
        self.collectionNameLabel.leftAnchor.constraint(equalTo: self.imageView.leftAnchor),
        self.collectionNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        self.collectionNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
