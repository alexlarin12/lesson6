//
//  AppDetailNewsBoxViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alex Larin on 28.06.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewsBoxViewController: UIViewController {

     // MARK: - Properties
 
 private let app: ITunesApp
 
 
 private var appDetailNewsBoxView: AppDetailNewsBoxView {
     return self.view as! AppDetailNewsBoxView
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
     self.view = AppDetailNewsBoxView()
 }
 
 override func viewDidLoad() {
     super.viewDidLoad()
     self.fillData()        // Do any additional setup after loading the view.
 }
 
 private func fillData() {
     
    self.appDetailNewsBoxView.titleLabel.text = "Что нового"
    self.appDetailNewsBoxView.subTitleLabel.text = app.appDescription
    self.appDetailNewsBoxView.numberVersionLabel.text = "Версия V 6.4"
    self.appDetailNewsBoxView.dateVersionLabel.text = "6 дней назад"
    self.appDetailNewsBoxView.titleVersionLabel.text = "История версий"
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
