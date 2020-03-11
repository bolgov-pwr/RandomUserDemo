//
//  APIRx.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/27/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class NetworkClient {
	
	func send<T: Codable>(request: APIRequest, callback: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
		
		let session = URLSession.shared
		
		let task = session.dataTask(with: request.getRequest()) { data, response, error in

			if let error = error {
				let customError = AppError.network(type: .custom(errorCode: (response as? HTTPURLResponse)?.statusCode, errorDescription: error.localizedDescription))
				callback(.failure(customError))
			} else {
				callback(APIResponse.response(type: T.self, data: data))
			}
		}

		task.resume()
		return task
    }
}

extension NetworkClient: ReactiveCompatible { }

extension Reactive where Base: NetworkClient {
	
	func send<T: Codable>(request: APIRequest) -> Observable<T> {
        return Observable.create { observer in
			let request = self.base.send(request: request, callback: self.sendResponse(into: observer))
            return Disposables.create() {
				request.cancel()
            }
		}.retry(3)
    }
    
	func sendResponse<T: Codable>(into observer: AnyObserver<T>) -> (Result<T, Error>) -> Void {
        return { result in
            switch result {
            case .success(let response):
                observer.onNext(response)
                observer.onCompleted()
            case .failure(let error):
                observer.onError(error)
            }
        }
    }
}
