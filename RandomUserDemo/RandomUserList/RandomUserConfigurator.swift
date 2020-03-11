//
//  RandomUserConfigurator.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

final class RandomUserConfigurator {
	
	let vc: RandomUserViewController
	private let type: ViewControllerConfigureType
	
	init(vc: RandomUserViewController, type: ViewControllerConfigureType) {
		self.vc = vc
		self.type = type
	}
	
	func configure(with service: RandomUserNetworkServiceProtocol) -> UIViewController {
		let vm = RandomUserViewModel(service: service)
		vc.randomUserVM = vm
		
		switch type {
		case .presentation:
			return vc
		case .navigation(let title):
			let navVC = UINavigationController(rootViewController: vc)
			vc.navigationItem.title = title
			navVC.navigationItem.title = title
			return navVC
		}
	}
}
