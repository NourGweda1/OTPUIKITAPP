//
//  OTPMain+Extension.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import Foundation

extension OTPMainView {

    func setUpData() {
        data = Array(repeating: "", count: textFieldCount)
        internalData = Array(repeating: "", count: textFieldCount)
        lastIndex = data.lastIndex(where: { !$0.isEmpty }) ?? 0

        if !mobileNumber.isEmpty {
          //  getOTPCode()
            register()
        }
    }

    private func register() {
        Task {
          let response = await otpHandler.register()
            debugPrint(response?.message ?? "", "🐙")
        }
    }

    private func getOTPCode() {
        Task {
            await otpHandler.sendOTP(mobileNumber: mobileNumber)
        }
    }

    func handleOnBackAction(isEmpty: Bool, index: Int) {
        //trial
        if (index == data.startIndex && data[index].isEmpty) || !isEmpty {
            data[index] = ""
        } else {
            if isEmpty {
                data[index - 1] = ""
            }
        }
        focusPreviousTextField(currentIndex: index)
    }

    func handleOnChangeAction() {
        lastIndex = data.lastIndex(where: { !$0.isEmpty }) ?? 0
        focusNextTextField(currentIndex: lastIndex)
        handleOnCompleteAction()
    }

    private func handleOnCompleteAction() {
        if data.filter({ !$0.isEmpty }).count == textFieldCount {
            onCompleteCallback(data.joined(separator: ""))
        }
    }

    
    // if finish trial change back to private <<<<< DONT FORGET TO RETURN PRIVATEEEE <<<<<<
    func focusNextTextField(currentIndex: Int) {
        let nextIndex = min(currentIndex + 1, textFieldCount - 1)
        focusedTextField = nextIndex
    }
    
    private func focusPreviousTextField(currentIndex: Int) {
        let previousIndex = max(currentIndex - 1, 0)
        focusedTextField = previousIndex
    }

    func getFocusedTextField() -> Int {
        let allDataIsEmpty = data.allSatisfy { $0.isEmpty }
        
        if allDataIsEmpty || isAllDataFull() {
            return allDataIsEmpty ? 0 : lastIndex
        } else {
            return lastIndex + 1
        }
    }

    func isAllDataFull() -> Bool {
        return data.allSatisfy { !$0.isEmpty }
    }

    func handleOnChangeFocus(newValue: Int) {
        lastIndex = data.lastIndex(where: { !$0.isEmpty }) ?? (data.isEmpty ? 0 : (data.count - 1))
        if data.isEmpty && newValue < lastIndex {
            focusedTextField = lastIndex
        }
    }



    func handleReceivingVerficationCode() {
        Task {
//            await otpHandler.verifyOTP()
        }
    }
}
