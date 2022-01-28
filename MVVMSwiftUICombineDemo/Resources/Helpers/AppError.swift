//
//  AppError.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation

enum AppError: Error, LocalizedError {
    case commonError(Error)
    case responseError(Int)
    case urlError(URLError)
    case decodingError(DecodingError)
    case customError(String)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .commonError(let error):
            return error.localizedDescription
        case .customError(let message):
            return message
        case .genericError:
            return "An unknown error has occured"
        }
    }
}
