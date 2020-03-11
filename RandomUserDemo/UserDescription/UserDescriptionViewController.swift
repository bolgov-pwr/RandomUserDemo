//
//  UserDescriptionViewController.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

final class UserDescriptionViewController: UIViewController {

	static func storyboardInstance() -> UserDescriptionViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? UserDescriptionViewController
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
    }
}
