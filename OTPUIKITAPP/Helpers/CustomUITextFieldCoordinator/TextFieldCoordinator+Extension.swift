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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        // This method is called when the user makes a selection or changes the text
        if let selectedRange = textField.selectedTextRange {
            let selectedText = textField.text(in: selectedRange)
            print("Selected Text: \(selectedText ?? "")")
            // You can check the selected text for specific keyboard suggestions
            // and perform actions accordingly
        }
    }
}
