//
//  AppError+File.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/29/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import Foundation

// MARK: - FIle Errors

extension AppError.Enums {
    enum FileError {
        case read(path: String)
        case write(path: String, value: Any)
        case custom(errorDescription: String?)
    }
}

extension AppError.Enums.FileError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .read(let path): return "Could not read file from \"\(path)\""
            case .write(let path, let value): return "Could not write value \"\(value)\" file from \"\(path)\""
            case .custom(let errorDescription): return errorDescription
        }
    }
}
