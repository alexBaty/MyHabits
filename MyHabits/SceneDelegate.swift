//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 26.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func createHabitsViewController() -> UINavigationController {
        let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
        habitsViewController.tabBarItem = UITabBarItem(title: "Habits", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        return habitsViewController
    }

    func createInfoViewController() -> UINavigationController {
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        infoViewController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        return infoViewController
    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createHabitsViewController(), createInfoViewController()]
        tabBar.tabBar.backgroundColor = .systemGray6
        tabBar.tabBar.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        return tabBar
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createTabBar()
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

