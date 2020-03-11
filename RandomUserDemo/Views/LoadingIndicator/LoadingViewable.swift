//
//  LoadingViewable.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/14/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import UIKit

protocol LoadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension LoadingViewable where Self : UIViewController {
	
    func startAnimating() {
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        view.addSubview(animateLoading)
		view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
		animateLoading.layer.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
	
    func stopAnimating() {
        for item in view.subviews where item.restorationIdentifier == "loadingView" {
			UIView.animate(withDuration: 0.3, animations: {
				item.alpha = 0
			}) { (_) in
				item.removeFromSuperview()
			}
        }
    }
}
