//
//  AppDelegate.swift
//  ThemeKit
//
//  Created by Zhang Yuf on 07/25/2023.
//  Copyright (c) 2023 Zhang Yuf. All rights reserved.
//

import UIKit
import ThemeKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Theme.launching(enabled: true)
        setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let nav = DNavigationViewController(rootViewController: ViewController())
        window?.rootViewController = nav
        
        Theme.Log.output { level, message, scope, file, line in
            let text = "\(scope) >>> \(message)"
            print(text)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Theme.saveTheme()
    }


}

private func setupAppearance() {
    Theme.navigationBarAppearance()
    Theme.textFieldAppearance()
    Theme.textViewAppearance()

    if #available(iOS 13.0, *) {
        UIApplication.shared.setStatusBarStyle(picker: [.darkContent, .lightContent], animated: true)
    }
    
    if let image = UIImage(named: "icon_search_hui")?.withRenderingMode(.alwaysOriginal) {
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
    }
    
    let tabbarItem = UITabBarItem.appearance()
    tabbarItem.setTitleTextAttributes([
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11),
        NSAttributedString.Key.foregroundColor: UIColor.common_level3_color
    ], for: .normal)
    tabbarItem.setTitleTextAttributes([
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: UIColor.common_level1_color
    ], for: .selected)
    
    if #available(iOS 15.0, *) {
        UITableView.appearance().sectionHeaderTopPadding = 0
        UITableView.appearance().isPrefetchingEnabled = false
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))

        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext(), let data = image.pngData() else { return nil }
        self.init(data: data, scale: image.scale)
    }
}
