//
//  NetworkServiceProtocol.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/29/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
	var source: APIClientSource { get }
	var networkClient: NetworkClient { get }
	
	init(source: APIClientSource)
}
