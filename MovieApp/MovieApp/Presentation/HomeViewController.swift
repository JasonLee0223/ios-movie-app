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
        
        configureOfUI()
        configureHierarchy()
        
        kakaoPosterImageTest { url in
            print("완료")
        }
//                test()
//        TVDBTest { imageURLStorage in
//            print(imageURLStorage)
//        }
    }
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource = HomeViewDataSource()
    
    let networkService = NetworkService()
    
    func kakaoPosterImageTest(completion: @escaping (URL) -> Void) {
        
        let mockData = ["분노의 질주: 라이드 오어 다이", "스즈메의 문단속", "슬픔의 삼각형", "가디언즈 오브 갤럭시: Volume 3",
         "극장판 짱구는 못말려: 동물소환 닌자 배꼽수비대", "더 퍼스트 슬램덩크", "슈퍼 마리오 브라더스",
         "문재인입니다", "드림", "존 윅 4"]
        
        networkService.loadMoviePosterImage(movieNameGroup: mockData) { document in
            guard let imageURL = URL(string:document.imageURL) else {
                return
            }
            completion(imageURL)
        }
    }
    
    func TVDBTest(completion: @escaping ([URL]) -> Void) {
        Task {
            
            var imageURLGroup = [URL]()
            
            self.networkService.loadTrendingMovieListData { resultStorage in
                
                let moviePosterPathGroup = resultStorage.map{ $0.movieImageURL }
                
                if let makeImgaeURL = try? moviePosterPathGroup.map({ posterImagePath in
                    let imageURLPath = "\(TVDBBasic.imageURL)\(posterImagePath)"
                    
                    guard let imageURL = URL(string: imageURLPath) else {
                        throw URLComponentsError.invalidComponent
                    }
                    return imageURL
                }) {
                    imageURLGroup = makeImgaeURL
                    completion(imageURLGroup)
                }
            }
        }
        //MARK: - 위 내용까지 imageURL 받아와서 디버깅으로 이미지까지 확인 완료
    }
    
    func test() {
        
        var movieInfoGroup = [MovieInfo]()
        
        networkService.loadDailyBoxOfficeData { dailyBoxOfficeListStorage in
            
            let movieCodegroup = dailyBoxOfficeListStorage.map{$0.movieCode}
            
            self.networkService.loadMovieDetailData(movieCodeGroup: movieCodegroup) { movieInfo in
                movieInfoGroup.append(movieInfo)
                print(movieInfo)
                //MARK: - 여기까지 MovieDetail 가져오는 로직 성공
            }
            
        }
    }
}

//MARK: - Configure of UI Components
extension HomeViewController {
    
    private func configureOfUI() {
        configureOfNavigationBar()
        configureOfSuperView()
        configureOfCollectionView()
    }
    
    private func configureOfSuperView() {
        self.view.backgroundColor = .black
    }
    
    private func configureOfNavigationBar() {
        let title: UIButton = {
            let title = UIButton()
            title.setTitle(
                MagicLiteral.RelatedToNavigationController.navigationTitle,
                for: .normal
            )
            title.titleLabel?.font = UIFont.systemFont(
                ofSize: MagicNumber.Attributes.navigationBarButtonFont,
                weight: .bold
            )
            title.tintColor = .white
            return title
        }()
        
        //TODO: - Button에 대한 Action이 필요하면 UIImageView를 클로저 형태로 변경
        let hamberg: UIBarButtonItem = {
            let hambergImage = UIImage(named: MagicLiteral.RelatedToNavigationController.hambergImageName)
            let hambergImageView = UIImageView(image: hambergImage)
            let hamberg = UIBarButtonItem(customView: hambergImageView)
            return hamberg
        }()
        
        let ticket: UIBarButtonItem = {
            let ticketImage = UIImage(named: MagicLiteral.RelatedToNavigationController.ticketImageName)
            let ticketImageView = UIImageView(image: ticketImage)
            let ticket = UIBarButtonItem(customView: ticketImageView)
            return ticket
        }()
        
        let map: UIBarButtonItem = {
            let map = UIBarButtonItem()
            map.image = UIImage(systemName: MagicLiteral.RelatedToNavigationController.mapImageName)
            map.tintColor = .white
            return map
        }()
        
        self.navigationItem.leftBarButtonItem = .init(customView: title)
        self.navigationItem.rightBarButtonItems = [hamberg, map, ticket]
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configureOfCollectionViewCompositionalLayout()
        collectionView.dataSource = dataSource
        
        collectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.register(MovieIntroduceCell.self, forCellWithReuseIdentifier: MovieIntroduceCell.identifier)
        collectionView.register(MovieGenreCell.self, forCellWithReuseIdentifier: MovieGenreCell.identifier)
    }
}

//MARK: - Configure of Layout
extension HomeViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureOfCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return HomeViewLayout(sectionIndex: sectionIndex).create()
        }
    }
}



//let aaa = moviePosterPathGroup.map { posterImagePath in
//    let makeImagePath = "\(TVDBBasic.imageURL)\(posterImagePath)"
//
//    guard let url = URL(string: makeImagePath) else {
//        return
//    }
//
//    var image : UIImage?
//
//    DispatchQueue.global().async {
//        if let data = try? Data(contentsOf: url) {
//            DispatchQueue.main.async {
//                image = UIImage(data: data)
//            }
//        }
//    }
//}
