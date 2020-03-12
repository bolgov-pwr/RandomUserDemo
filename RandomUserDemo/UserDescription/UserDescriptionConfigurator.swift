//
//  UserDescriptionConfigurator.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

final class UserDescriptionConfigurator {
	
	let vc: UserDescriptionViewController
	private let type: ViewControllerConfigureType
	
	init(vc: UserDescriptionViewController, type: ViewControllerConfigureType) {
		self.vc = vc
		self.type = type
	}
	
	func configure(with person: Person) -> UIViewController {
		vc.person.onNext(person)
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
