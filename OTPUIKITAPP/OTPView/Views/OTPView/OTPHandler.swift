//
//  OTPHandler.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 21/08/2023.
//

import Foundation
import Firebase

extension OTPMainView {
    @MainActor
    class OTPHandler: ObservableObject {
        @Published var otpCode: String = ""
        @Published var verificationCode: String = ""
        @Published var errorMsg: String = ""
        @Published var showAlert: Bool = false
        @Published var isLoading: Bool = false

        private var registrationUseCase = RegistrationUseCase(repo: RegistrationRepoImpl())

        func register() async -> RegisterModel? {
            let response = await registrationUseCase.register(phoneNum: "01201388540")
            isLoading = false
            switch response {
            case .success(let successResponse):
                return successResponse
            case .failure(let error):
                errorMsg = error.errorDescription
            }
            return nil
        }

        func sendOTP(mobileNumber: String) async {
            do {
                isLoading = true
                let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNumber)", uiDelegate: nil)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.verificationCode = result
                    Task {
                        await self.verifyOTP()
                    }
                }
            } catch {
                handleError(error: error.localizedDescription)
            }
        }

        func handleError(error: String) {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMsg = error
                self.showAlert.toggle()
            }
        }

        func verifyOTP() async {
            do {
                self.isLoading = true
                let verCode = "123456"
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: verCode)
                let result = try await Auth.auth().signIn(with: credential)
                debugPrint("🐙🐙🐙🐙🐙🐙")
                debugPrint(result.credential, "credential")
                debugPrint(result.additionalUserInfo, "additionalUserInfo")
                debugPrint(result.user, "user")
                debugPrint("🐙🐙🐙🐙🐙🐙")
                debugPrint(otpCode, "🐙")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } catch {
                handleError(error: error.localizedDescription)
            }
        }
    }
}
