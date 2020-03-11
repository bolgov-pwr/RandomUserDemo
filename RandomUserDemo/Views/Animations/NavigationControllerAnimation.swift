//
//  NavigationControllerAnimation.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

final class NavigationControllerAnimation {
	
	static let push: CATransition = {
		let transition: CATransition = CATransition()
		transition.duration = 0.3
		transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		transition.type = CATransitionType.fade
		return transition
	}()
}
