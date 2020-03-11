//
//  RandomuserAPIClient.swift
//  GitHubDemo
//
//  Created by Ivan Bolgov on 5/24/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

final class RandomUserNetworkSource: APIClientSource {
	let baseURL = URL(string: "https://randomuser.me/")!
}
