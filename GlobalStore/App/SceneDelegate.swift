//
//  SceneDelegate.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        showMainVC()
    }
}

// MARK: - Show Controller

extension SceneDelegate {
    private func showMainVC() {
        let mainVC = MainViewControllerFactory().makeMainViewController()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
