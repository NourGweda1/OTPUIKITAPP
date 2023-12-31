//
//  TextFieldCoordinator.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import Foundation
import SwiftUI

class EnhancedTextFieldCoordinator: NSObject {
    let textBinding: Binding<String>
    var onChange: ((String) -> Void)?
    var data: Binding<[String]>
    var currentIndex: Binding<Int>

    init(textBinding: Binding<String>, onChange: @escaping (String) -> Void,
         data: Binding<[String]>, currentIndex: Binding<Int>) {
        self.textBinding = textBinding
        self.onChange = onChange
        self.data = data
        self.currentIndex = currentIndex
    }
}
