//
//  AuthProvider.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

enum AuthProvider: NetworkApis {
    case register(phoneNum: String)
}

extension AuthProvider {
    var baseURL: URL {
        return URL(string: "https://exm-pv-api.trianglz.com/user_app/v1")!
    }

    var path: String {
        switch self {
        default:
            return "/users/entry"
        }
    }

    var method: HttpMethods {
        switch self {
        default:
            return .post
        }
    }

    var header: [String: String] {
        switch self {
        default:
            return [:]
        }
    }

    var parameters: ParametersType {
        switch self {
        case .register(let phoneNum):
            return .requestBody(parameters:
                ["phone_number": phoneNum]
            )
        }
    }
}
