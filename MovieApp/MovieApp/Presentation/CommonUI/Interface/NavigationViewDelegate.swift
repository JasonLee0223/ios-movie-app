//
//  NavigationViewDelegate.swift
//  MovieApp
//
//  Created by Jason on 2023/09/12.
//

import Foundation

protocol NavigationViewDelegate: AnyObject {
    func navigationView(_ navigationView: NavigationView, didTapRightBarItem rightBarItem: NavigationView.RightBarItem)
}
