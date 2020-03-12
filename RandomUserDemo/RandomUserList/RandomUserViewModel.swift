//
//  RandomUserViewModel.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RandomUserViewModel: RxBindable {
	
	fileprivate var networkService: RandomUserNetworkServiceProtocol
	
	required init(service: RandomUserNetworkServiceProtocol) {
		self.networkService = service
	}
	
	let disposeBag = DisposeBag()
	
	public let users: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
	public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<AppError> = PublishSubject()
	
	func requestData(isReload: Bool = false) {
		
		if isReload {
			self.loading.onNext(true)
		}
		
		networkService.getUsers(with: 20)
			.subscribe(onNext: { [weak self] personRespond in
				if isReload {
					self?.loading.onNext(false)
				}
				if let users = personRespond.persons, !users.isEmpty {
					if !isReload {
						var prevValues = [Person]()
						if let values = try? self?.users.value() {
							prevValues = values
						}
						self?.users.onNext(prevValues + users)
					} else {
						self?.users.onNext(users)

					}
				}
			}, onError: { [weak self] err in
				if let error = err as? AppError {
					self?.error.onNext(error)
				}
				if isReload {
					self?.loading.onNext(false)
				}
			})
			.disposed(by: disposeBag)
	}
}
