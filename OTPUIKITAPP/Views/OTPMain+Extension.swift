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
        lastIndex = data.lastIndex(where: { !$0.isEmpty }) ?? 0
    }

    func handleOnBackAction(isEmpty: Bool, index: Int) {
        if !isEmpty {
            data[index] = ""
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

    private func focusNextTextField(currentIndex: Int) {
        let nextIndex = min(currentIndex + 1, textFieldCount - 1)
        focusedTextField = nextIndex
    }
    
    private func focusPreviousTextField(currentIndex: Int) {
        let previousIndex = max(currentIndex - 1, 0)
        focusedTextField = previousIndex
    }

    func getFocusedTextField() -> Int {
        let isAllFilledExceptLast = data.dropLast().allSatisfy { !$0.isEmpty } && data.last?.isEmpty == true

        if isAllFilledExceptLast {
            return lastIndex + 1
        } else {
           return lastIndex
        }
    }

    func handleOnChangeFocus(newValue: Int) {
        lastIndex = data.lastIndex(where: { !$0.isEmpty }) ?? (data.isEmpty ? 0 : (data.count - 1))
        if data.isEmpty && newValue < lastIndex {
            focusedTextField = lastIndex
        }
    }

}