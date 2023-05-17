//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureOfNavigationBar()
        configureOfSuperView()
    }


}

extension HomeViewController {
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfNavigationBar() {
        let title: UIButton = {
            let title = UIButton()
            title.setTitle("야곰 시네마 🐻‍❄️", for: .normal)
            title.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            title.tintColor = .white
            return title
        }()
        self.navigationItem.leftBarButtonItem = .init(customView: title)
        
    }
}
