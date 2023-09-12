//
//  NavigationView.swift
//  MovieApp
//
//  Created by Jason on 2023/09/12.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class NavigationView: UIView {
    
    weak var delegate: NavigationViewDelegate?
    
    init(rightBarItems: [RightBarItem]) {
        self.titleLabel = UILabel()
        self.rightBarItems = rightBarItems
        
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.setupUI()
        self.bindAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 375, height: 60)
    }

    private let titleLabel: UILabel
    private let rightBarItems: [RightBarItem]
    private var boxOfficeButton: UIButton?
    private var profileButton: UIButton?

    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.titleLabel.text = MagicLiteral.RelatedToNavigationController.navigationTitle
        self.titleLabel.textColor = .systemGreen
        self.titleLabel.font = .boldSystemFont(ofSize: MagicNumber.Attributes.navigationBarButtonFont)
        
        self.rightBarItems.forEach { barItem in
            switch barItem {
            case .boxOffice:
                self.boxOfficeButton = barItem.makeButton()
            case .profile:
                self.profileButton = barItem.makeButton()
            }
        }
    }
    
    private func setupLayout() {
        guard let boxOfficeButton, let profileButton else { return }
        let stackView = UIStackView()
        
        self.addSubview(titleLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(boxOfficeButton)
        stackView.addArrangedSubview(profileButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.width.equalTo(269)
            make.height.equalTo(34)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-18)
            make.centerY.equalToSuperview()
        }
    }
    
    private func bindAction() {
        let disposeBag = DisposeBag()
        
        self.boxOfficeButton?.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.delegate?.navigationView(owner, didTapRightBarItem: .boxOffice)
            })
            .disposed(by: disposeBag)
        
        self.profileButton?.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.delegate?.navigationView(owner, didTapRightBarItem: .profile)
            })
            .disposed(by: disposeBag)
    }
}

extension NavigationView {
    
    enum RightBarItem: Int, BarItem {
        case boxOffice = 0
        case profile
        
        var image: UIImage? {
            switch self {
            case .boxOffice:
                return UIImage(systemName: "film")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            case .profile:
                return UIImage(systemName: "person.crop.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            }
        }
    }
}
