//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Jason on 2023/05/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
            
        
        let homeViewController = HomeViewController()
        let boxOfficeController = BoxOfficeViewController()
        let profileController = ProfileViewController()
        
        let tabbarController = UITabBarController()
        let rootViewController = UINavigationController(rootViewController: homeViewController)
        
        tabbarController.setViewControllers(
            [rootViewController, boxOfficeController, profileController], animated: true
        )
        
        if let tabItem = tabbarController.tabBar.items {            
            tabItem[0].image = UIImage(systemName: "house")
            tabItem[1].image = UIImage(systemName: "film.stack")
            tabItem[2].image = UIImage(systemName: "person.crop.circle")
        }
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

