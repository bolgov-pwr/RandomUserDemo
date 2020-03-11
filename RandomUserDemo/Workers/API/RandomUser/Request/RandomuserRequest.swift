//
//  RandomuserRequest.swift
//  GitHubDemo
//
//  Created by Ivan Bolgov on 5/24/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

final class RandomuserRequest: APIRequest {
	
	let method: RequestType = .GET
	let path: String = "api"
	var parameters: [String : String] = [:]
	let fullAdres: URL
	
	init(limitOfPersons: Int, source: APIClientSource) {
		parameters["results"] = "\(limitOfPersons)"
		var baseURL = source.baseURL
		baseURL.appendPathComponent(path)
		self.fullAdres = baseURL
	}
}
