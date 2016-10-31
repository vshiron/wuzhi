//
//  AppDelegate.swift
//  wuzhi
//
//  Created by vshiron on 16/10/9.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 更改状态栏颜色
        application.isStatusBarHidden = false
        application.statusBarStyle = .default;
        
        
        let tabbarVC = BaseTabBarController()
        

        
        // 设置window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        window?.rootViewController = tabbarVC;
        window?.makeKeyAndVisible()
        
        
        
        
        // Override point for customization after application launch.
        return true
    }




}

