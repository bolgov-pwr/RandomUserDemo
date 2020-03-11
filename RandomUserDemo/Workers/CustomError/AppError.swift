//
//  APIWorker_mock.swift
//  GitHubDemo
//
//  Created by Ivan Bolgov on 2/9/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

enum AppError {
    case network(type: Enums.NetworkError)
    case file(type: Enums.FileError)
    case custom(errorDescription: String?)

    class Enums { }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .network(let type): return type.localizedDescription
            case .file(let type): return type.localizedDescription
            case .custom(let errorDescription): return errorDescription
        }
    }
}
