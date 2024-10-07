//
//  SceneDelegate.swift
//  CarImageDownloader
//
//  Created by User on 04.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = UINavigationController(rootViewController: MainImageViewController())
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

