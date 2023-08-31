//
//  Constants+APIErrors.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

extension Constants {

    struct ApiError {
        static let noInternetConnection = String(localized: "No Internet Connection")
        static let forbidden = String(localized: "Forbidden")
        static let invalidCredentials = String(localized: "Invalid Credential")
        static let serverError = String(localized: "Server Error")
        static let badRequest = String(localized: "Bad Request")
        static let notFound = String(localized: "Not Found")
        static let unprocessableEntity = String(localized: "Unprocessable Entity")
    }
}
