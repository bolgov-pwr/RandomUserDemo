//
//  RxBindable.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/14/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

protocol RxBindable {
	var disposeBag: DisposeBag { get }
}
