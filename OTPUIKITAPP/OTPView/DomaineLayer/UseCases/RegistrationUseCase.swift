//
//  RegistrationUseCase.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

struct RegistrationUseCase {

    var repo: RegistrationRepo

    func register(phoneNum: String) async -> Result<RegisterModel, ApiErrors> {
        do {
            guard let response = try await repo.register(phoneNum: phoneNum)
            else {return .failure(ApiErrors.unprocessableEntity)}
            return .success(response)
        } catch {
            if let error = error as? ApiErrors {
                return .failure(error)
            } else {
                return .failure(.badRequest)
            }
        }
    }
}
