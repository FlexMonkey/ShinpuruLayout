//
//  AppDelegate.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
// Icon created by Manav Dhiman from the Noun Project


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        application.statusBarStyle = UIStatusBarStyle.LightContent
        
        let tabbar = UITabBarController()
        let icon = UIImage(named: "noun_19113_cc.png") // Icon created by Manav Dhiman from the Noun Project
        
        let complexGrid = ComplexGrid()
        complexGrid.tabBarItem.title = "Complex Grid"
        complexGrid.tabBarItem.image = icon

        let softimageLayout = SoftimageLayout()
        softimageLayout.tabBarItem.title = "Softimage Layout"
        softimageLayout.tabBarItem.image = icon
        
        let alignAndDistribute = AlignAndDistribute()
        alignAndDistribute.tabBarItem.title = "Align & Distribute"
        alignAndDistribute.tabBarItem.image = icon
        
        
        tabbar.viewControllers = [softimageLayout, complexGrid, alignAndDistribute]
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        return true
    }



}

