//
//  APIRequest.swift
//  GitHubDemo
//
//  Created by Ivan Bolgov on 2/13/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

public enum RequestType: String {
	case GET, POST
}

protocol APIRequest {
	var method: RequestType { get }
	var path: String { get }
	var parameters: [String : String] { get }
	
	var fullAdres: URL { get }
}

extension APIRequest {
	
	func getRequest() -> URLRequest {
		guard var components = URLComponents(url: fullAdres, resolvingAgainstBaseURL: false) else {
			fatalError("Unable to create URL components")
		}
		
		components.queryItems = parameters.map {
			URLQueryItem(name: String($0), value: String($1))
		}
		
		guard let url = components.url else {
			fatalError("Could not get url")
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
}

