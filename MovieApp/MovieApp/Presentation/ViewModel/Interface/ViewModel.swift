//
//  ViewModel.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation

protocol ViewModel {
    associatedtype Action
    associatedtype State
    
    var action: Action { get }
    var state: State { get }
}
