//
//  APIClientSource.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/29/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

protocol APIClientSource : class {
	var baseURL: URL { get }
}
