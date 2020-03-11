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
		
		let randomUserScreen = RandomUserConfigurator(vc: RandomUserViewController.storyboardInstance()!,
													  type: .navigation(title: "Random User List"))
		let vc = randomUserScreen.configure(with: RandomUserNetworkService(source: RandomUserNetworkSource()))
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = vc
		self.window?.makeKeyAndVisible()
		
		return true
	}
}

