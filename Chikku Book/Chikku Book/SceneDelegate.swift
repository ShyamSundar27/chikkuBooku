//
//  SceneDelegate.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
       
        
        if UserDefaults.standard.bool(forKey: "isLogged") {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            let homePageVc = UINavigationController(rootViewController: HomePageViewController())
            let myTransactionsVc = UINavigationController(rootViewController: MyBookingsViewController())
            let myProfileVc = UINavigationController(rootViewController: ProfileTabViewController())


            homePageVc.tabBarItem.image = UIImage(systemName: "house")

            myTransactionsVc.title = "My Bookings"
            myTransactionsVc.tabBarItem.image = UIImage(systemName: "note.text")

            myProfileVc.title = "My Profile"
            myProfileVc.tabBarItem.image = UIImage(systemName: "person.fill")

            tabBarController.setViewControllers([homePageVc,myTransactionsVc,myProfileVc], animated: true)
            tabBarController.tabBar.backgroundColor = .systemBackground
            let rootViewController = tabBarController

            tabBarController.tabBar.tintColor = .systemGreen

            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            self.window = window
            
            let theme = UserDefaults.standard.integer(forKey: "theme")
            
            window.overrideUserInterfaceStyle = Theme(rawValue: theme)!.uiInterfaceStyle
           
            
        }
        
        
        else {
           
           
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window = UIWindow(windowScene: windowScene)
            //let tabBarController = UITabBarController()
            let signUpPageVc = UINavigationController(rootViewController: SignUpViewController())
            
            window.rootViewController = signUpPageVc
            window.makeKeyAndVisible()
            self.window = window
            
            let theme = UserDefaults.standard.integer(forKey: "theme")
            
            
            window.overrideUserInterfaceStyle = Theme(rawValue: theme)!.uiInterfaceStyle
            
        }
        UserDefaults.standard.addObserver(self, forKeyPath: "theme", options: [.new], context: nil)
        
        
        //DBManager.getInstance().
        
        
//
//        let navigationController = UINavigationController()
//        let rootViewController = LoginPageVc()
//        navigationController.viewControllers = [rootViewController]
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        self.window = window
        
        
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
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard
            let change = change,
            object != nil,
            keyPath == keyPath,
            let themeValue = change[.newKey] as? Int,
            let theme = Theme(rawValue: themeValue)?.uiInterfaceStyle
        else { return }

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: { [weak self] in
            self?.window?.overrideUserInterfaceStyle = theme
        }, completion: .none)
    }
    
    
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: "theme", context: nil)
    }
    

    
    
}

