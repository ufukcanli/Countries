//
//  TabBarController.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
    }

    private func configureTabBarController() {
        tabBar.tintColor = .label
        viewControllers = [
            createNavigationController(viewController: UIViewController(), title: "Home", imageName: "house"),
            createNavigationController(viewController: UIViewController(), title: "Saved", imageName: "heart.fill")
        ]
    }
}

private extension TabBarController {
    
    func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .systemBackground
        navigationController.tabBarItem.title = title
        viewController.navigationItem.title = "Countries"
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .label
        navigationController.tabBarItem.image = UIImage(systemName: imageName)
        return navigationController
    }
}
