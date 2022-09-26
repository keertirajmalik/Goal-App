//
//  MainTabBarController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 18/09/22.
//

import UIKit

// MARK: - BaseTabBar

class BaseTabBarController: UITabBarController {
    var navigationViewControllers = [UINavigationController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCustomization()
        setupViewControllers()
    }

    func setupCustomization() {}
    func setupViewControllers() {}
}

// MARK: - SampleTabBar

class MainTabBarController: BaseTabBarController {
    override func setupCustomization() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }

    override func setupViewControllers() {
        var storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController

        storyboard = UIStoryboard(name: "PersonalGoals", bundle: nil)
        let personalGoalViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.personalGoalsViewController) as? PersonalGoalsViewController

        if let homeViewController = homeViewController, let personalGoalViewController = personalGoalViewController {
            let homeTab = UINavigationController(rootViewController: homeViewController)
            let goalTab = UINavigationController(rootViewController: personalGoalViewController)

            homeTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
            goalTab.tabBarItem = UITabBarItem(title: "Goals", image: UIImage(systemName: "target"), selectedImage: nil)

            navigationViewControllers.append(homeTab)
            navigationViewControllers.append(goalTab)
        } else {
            fatalError("Failure while transitioning to Home screen")
        }
    }
}
