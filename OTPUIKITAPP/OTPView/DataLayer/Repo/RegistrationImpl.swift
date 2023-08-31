//
//  RegistrationImpl.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

struct RegistrationRepoImpl: RegistrationRepo {

    func register(phoneNum: String) async throws -> RegisterModel? {
        let registrationResponse = try await NetworkClient.shared.callApiAsync(target: AuthProvider.register(phoneNum: phoneNum), model: RegisterModel.self)
        
        return registrationResponse
    }
}
