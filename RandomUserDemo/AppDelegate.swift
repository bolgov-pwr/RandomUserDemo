//
//  AppDelegate.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let vc = RandomUserViewController.storyboardInstance() ?? UIViewController()
		let navVC = UINavigationController(rootViewController: vc)
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = navVC
		self.window?.makeKeyAndVisible()
		
		return true
	}
}

