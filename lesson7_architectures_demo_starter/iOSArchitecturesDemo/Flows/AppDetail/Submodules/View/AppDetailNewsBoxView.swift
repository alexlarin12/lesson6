//
//  AppDetailNewsBoxView.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 28.06.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewsBoxView: UIView {

    // MARK: - Subviews
    
    // Label - Что Нового
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        return label
    } ()
    // Label - Описание
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 4
        return label
    } ()
    // Label - Версия
    private(set) lazy var numberVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    } ()
    // Label - Заголовок версии
    private(set) lazy var titleVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    } ()
    // Label - Дата релиза версии
    private(set) lazy var dateVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
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
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.numberVersionLabel)
        self.addSubview(self.dateVersionLabel)
        self.addSubview(self.titleVersionLabel)
        
        NSLayoutConstraint.activate([
        self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
        self.titleLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16.0),
        self.titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.titleVersionLabel.leftAnchor, constant: 20),
   
        self.numberVersionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24.0),
        self.numberVersionLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
        self.numberVersionLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.dateVersionLabel.rightAnchor, constant: 20.0),
       
        self.dateVersionLabel.centerYAnchor.constraint(equalTo: self.numberVersionLabel.centerYAnchor),
        self.dateVersionLabel.rightAnchor.constraint(equalTo: self.titleVersionLabel.rightAnchor),
        
        self.subTitleLabel.topAnchor.constraint(equalTo: self.numberVersionLabel.bottomAnchor, constant: 24.0),
        self.subTitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
        self.subTitleLabel.rightAnchor.constraint(equalTo: self.titleVersionLabel.leftAnchor),
        self.subTitleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10),
       
        self.titleVersionLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        self.titleVersionLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant:
            -16.0)
            
        ])
    }
}
