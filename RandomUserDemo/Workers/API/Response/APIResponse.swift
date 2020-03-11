//
//  APIResponse.swift
//  GitHubDemo
//
//  Created by Ivan Bolgov on 2/19/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

enum ResponseError: Error {
	case invalidParameters
	case cannotParseJson
}

final class APIResponse {
	
	static func response<T: Codable>(type: T.Type, data: Data?) -> Result<T, Error> {
		
		guard let data = data else {
			return .failure(AppError.network(type: .notFound))
		}
		
		guard let result = try? JSONDecoder().decode(T.self, from: data) else {
			return .failure(AppError.network(type: .parsing))
		}
		return .success(result)
	}
}
