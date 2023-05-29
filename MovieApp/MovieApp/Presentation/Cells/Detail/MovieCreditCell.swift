//
//  MovieCreditCell.swift
//  MovieApp
//
//  Created by Jason on 2023/05/28.
//

import UIKit

final class MovieCreditCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        configureOfLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOfLayout()
    }
    
    //MARK: - Private Property
    
    private let horizontalTotalUIStack: UIStackView = {
        let horizontalTotalUIStack = UIStackView()
        horizontalTotalUIStack.axis = .horizontal
        horizontalTotalUIStack.alignment = .center
        horizontalTotalUIStack.spacing = 10
        return horizontalTotalUIStack
    }()
    
    private let creditMemberStack: UIStackView = {
        let creditMemberStack = UIStackView()
        creditMemberStack.axis = .vertical
        creditMemberStack.alignment = .center
        creditMemberStack.distribution = .fillProportionally
        return creditMemberStack
    }()
    
    private let peopleImage: UIImageView = {
        let peopleImage = UIImageView()
        peopleImage.image = UIImage(named: "Suzume")
        peopleImage.contentMode = .scaleAspectFill
        
        peopleImage.layer.masksToBounds = true
        peopleImage.layer.cornerRadius = 48
        peopleImage.layer.borderWidth = 1.0
        peopleImage.layer.borderColor = UIColor.clear.cgColor
        peopleImage.clipsToBounds = true
        return peopleImage
    }()
    
    private let peopleName: UILabel = {
        let peopleName = UILabel()
        peopleName.font = .systemFont(ofSize: 16)
        peopleName.textColor = .white
        return peopleName
    }()
    
    private let role: UILabel = {
        let role = UILabel()
        role.font = .systemFont(ofSize: 14)
        role.textColor = .white
        return role
    }()
}

//MARK: - [Public Method] Configure of UI Components
extension MovieCreditCell {
    
    func configure(_ item: [String], at indexPath: IndexPath) {
        
        //TODO: - Need to setUp the UI Componenets
        setPeopleName(by: item[0])
        setRole(by: item[1])
    }
}

//MARK: - [Private Method] Configure of UI Components
extension MovieCreditCell {
    
    func setPeopleImage(by data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        peopleImage.image = image
    }
    
    func setPeopleName(by text: String) {
        peopleName.text = text
    }
    
    func setRole(by text: String) {
        role.text = text
    }
}

//MARK: - [Private Method] Configure of Layout
extension MovieCreditCell {
    
    
    private func configureOfLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.addSubview(horizontalTotalUIStack)
        horizontalTotalUIStack.addArrangedSubview(peopleImage)
        horizontalTotalUIStack.addArrangedSubview(creditMemberStack)
        creditMemberStack.addArrangedSubview(peopleName)
        creditMemberStack.addArrangedSubview(role)
        
        horizontalTotalUIStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalTotalUIStack.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            horizontalTotalUIStack.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            horizontalTotalUIStack.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            horizontalTotalUIStack.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
        
        creditMemberStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creditMemberStack.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.65
            )
        ])
        
        peopleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            peopleImage.widthAnchor.constraint(
                equalTo: horizontalTotalUIStack.heightAnchor
            ),
            peopleImage.heightAnchor.constraint(
                equalTo: horizontalTotalUIStack.heightAnchor
            )
        ])
    }
    
}
