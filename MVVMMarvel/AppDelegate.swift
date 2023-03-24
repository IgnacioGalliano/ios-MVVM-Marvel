//
//  AppDelegate.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        /* Initiating instance of ui-navigation-controller with view-controller */
        let viewController = CharactersListBuilder.build()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]

        /* Setting up the root view-controller as ui-navigation-controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
