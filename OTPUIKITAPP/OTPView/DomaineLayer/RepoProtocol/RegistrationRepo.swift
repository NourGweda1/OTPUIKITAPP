//
//  RegistrationRepo.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

protocol RegistrationRepo {
    func register(phoneNum: String) async throws -> RegisterModel?
}
