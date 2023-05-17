//
//  ViewController.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureOfSuperView()
    }


}

extension HomeViewController {
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
}
