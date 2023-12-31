//
//  TextFieldCoordinator+Extension.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import Foundation
import SwiftUI

extension EnhancedTextFieldCoordinator: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

        setUserDefaultsData(newText: newText)
        if let savedArray = UserDefaults.standard.stringArray(forKey: "DataInternal") {
            if getNonEmptyCount(array: savedArray) == data.count {
                debugPrint("Saved Array: \(savedArray)")
                data.wrappedValue = savedArray
                let emptyArray: [String] = []
                UserDefaults.standard.set(emptyArray, forKey: "DataInternal")
                return true
            }
        } else {
            debugPrint("Array not found in UserDefaults.")
        }

        if !newText.isEmpty && (newText.count == 1) && areElementsNotEmpty() {
            textBinding.wrappedValue = String(newText.prefix(1))
            onChange?(newText)
            return false
        } else if newText.count > 1 {
            if currentIndex.wrappedValue != (data.count - 1) {
                let secondCharacter = newText[newText.index(newText.startIndex, offsetBy: 1)]
                data.wrappedValue[currentIndex.wrappedValue + 1] = String(secondCharacter)
            }
            onChange?(newText)
            return false
        } else {
            return true
        }
    }

    func areElementsNotEmpty() -> Bool {
        let subArray = data.prefix(currentIndex.wrappedValue)
        return subArray.allSatisfy { !$0.wrappedValue.isEmpty }
    }

    func setUserDefaultsData(newText: String) {
        var stringArray = UserDefaults.standard.stringArray(forKey: "DataInternal") ?? []

        if newText.count == 1 {
            stringArray.append(String(newText))
            stringArray.removeAll { $0.isEmpty }

            UserDefaults.standard.set(stringArray, forKey: "DataInternal")
        }
    }
    
    func getNonEmptyCount(array: [String]) -> Int {
        var nonEmptyCount = 0
        for item in array {
            if !item.isEmpty {
                nonEmptyCount += 1
            }
        }
        return nonEmptyCount
    }
}
