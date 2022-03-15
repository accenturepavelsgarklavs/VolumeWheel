//
//  AppDelegate.swift
//  VolumeWheel
//
//  Created by pavels.garklavs on 15/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        navigationController = UINavigationController(rootViewController: makeVolumeWheelController())

        window?.rootViewController = navigationController
        return true
    }
}

private extension AppDelegate {
    func makeVolumeWheelController() -> UIViewController {
        let volumeWheelController = VolumeWheelViewController()
        
        return volumeWheelController
    }
}
