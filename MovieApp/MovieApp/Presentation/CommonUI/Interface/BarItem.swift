//
//  BarItem.swift
//  MovieApp
//
//  Created by Jason on 2023/09/12.
//

import UIKit

protocol BarItem {
    var image: UIImage? { get }
    func makeButton() -> UIButton
}

extension BarItem {
    func makeButton() -> UIButton {
        let button = UIButton()
        button.setImage(self.image, for: .normal)
        return button
    }
}
