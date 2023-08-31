//
//  ApiErrorsEnum.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation

public enum ApiErrors: Error {
    case badRequest            // Possibly the parameters are invalid
    case invalidCredential    // INVALID CREDENTIAL, possible invalid token
    case notFound          // The item you looked for is not found
    case serverError             // Error from Server
    case unprocessableEntity
    case forbidden
    case noInternet
    case custom(errorMsg: String)
    case none

    var errorDescription: String {
        switch self {
        case .badRequest:
            return Constants.ApiError.badRequest
        case .notFound:
            return Constants.ApiError.notFound
        case .serverError:
            return Constants.ApiError.serverError
        case .invalidCredential:
            return Constants.ApiError.invalidCredentials
        case .unprocessableEntity:
            return Constants.ApiError.unprocessableEntity
        case .forbidden:
            return Constants.ApiError.forbidden
        case .noInternet:
            return Constants.ApiError.noInternetConnection
        case .custom(let errorMsg):
            return errorMsg
        default:
            return ""
        }
    }

    static func getErrorType(with code: Int) -> ApiErrors {
        switch code {
        case 400:
            return .badRequest        // Possibly the parameters are invalid
        case 401:
            return .invalidCredential      // INVALID CREDENTIAL, possible invalid token
        case 404:
            return .notFound             // The item you looked for is not found
        case 500:
            return .serverError            // Error from Server
        case 422:
            return .unprocessableEntity
        case 403:
            return .forbidden
        default:
            return .none
        }
    }
}
