//
//  Extensions.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/14/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {
    
    public var isSpinnerAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
}

extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}

extension TimeInterval{

	func stringFromTimeInterval() -> String {
		let time = NSInteger(self)
		let seconds = time % 60
		let minutes = (time / 60) % 60
		return String(format: "%0.2d:%0.2d", minutes, seconds)
	}
}
