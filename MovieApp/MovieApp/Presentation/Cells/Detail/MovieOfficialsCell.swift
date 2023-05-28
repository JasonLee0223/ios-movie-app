//
//  MovieOfficialsCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieOfficialsCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        configureOfLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    //MARK: - Private Property
    
    private let movieOfficialsStack: UIStackView = {
        let movieOfficialsStack = UIStackView()
        movieOfficialsStack.axis = .vertical
        movieOfficialsStack.alignment = .center
        movieOfficialsStack.distribution = .fill
        return movieOfficialsStack
    }()
    
    private let peopleName: UILabel = {
        let peopleName = UILabel()
        peopleName.font = .systemFont(ofSize: 14)
        peopleName.textColor = .white
        return peopleName
    }()
    
    private let role: UILabel = {
        let role = UILabel()
        role.font = .systemFont(ofSize: 12)
        role.textColor = .white
        return role
    }()
}

//MARK: - [Public Method] Configure of UI Components
extension MovieOfficialsCell {
    
    func configure(_ item: [String], at indexPath: IndexPath) {
        
        //TODO: - Need to setUp the UI Componenets
        setPeopleName(by: item[0])
        setRole(by: item[1])
    }
}

//MARK: - [Private Method] Configure of UI Components
extension MovieOfficialsCell {
    
    private func setPeopleName(by text: String) {
        peopleName.text = text
    }
    
    private func setRole(by text: String) {
        role.text = text
    }
}

//MARK: - [Private Method] Configure of Layout
extension MovieOfficialsCell {
    
    
    private func configureOfLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.contentView.addSubview(movieOfficialsStack)
        movieOfficialsStack.addArrangedSubview(peopleName)
        movieOfficialsStack.addArrangedSubview(role)
        
        movieOfficialsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieOfficialsStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            movieOfficialsStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            movieOfficialsStack.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            movieOfficialsStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])

        peopleName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            peopleName.topAnchor.constraint(
                equalTo: movieOfficialsStack.topAnchor
            ),
            peopleName.leadingAnchor.constraint(
                equalTo: movieOfficialsStack.leadingAnchor
            ),
            peopleName.trailingAnchor.constraint(
                equalTo: movieOfficialsStack.trailingAnchor
            ),
            peopleName.bottomAnchor.constraint(
                equalTo: role.topAnchor
            )
        ])
        
        role.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            role.topAnchor.constraint(
                equalTo: role.topAnchor
            ),
            role.leadingAnchor.constraint(
                equalTo: role.leadingAnchor
            ),
            role.trailingAnchor.constraint(
                equalTo: role.trailingAnchor
            ),
            role.bottomAnchor.constraint(
                equalTo: role.bottomAnchor
            )
        ])
    }
    
}
