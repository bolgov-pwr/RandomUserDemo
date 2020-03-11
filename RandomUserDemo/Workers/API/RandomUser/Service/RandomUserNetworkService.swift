//
//  RandomUserNetworkService.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/29/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

protocol RandomUserNetworkServiceProtocol {
	
	func getUsers(with limit: Int) -> Observable<Persons>
}

final class RandomUserNetworkService: NetworkServiceProtocol {

	var source: APIClientSource
	var networkClient: NetworkClient = NetworkClient()
	
	init(source: APIClientSource) {
		self.source = source
	}
}

extension RandomUserNetworkService: RandomUserNetworkServiceProtocol {
	
	func getUsers(with limit: Int) -> Observable<Persons> {
		return networkClient.rx.send(request: RandomuserRequest(limitOfPersons: limit, source: source))
	}
}
