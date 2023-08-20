//
//  View+TFModifier.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import Foundation
import SwiftUI

extension View {
    func customTextFieldModifier(customStyle: CustomStyle,
                                 index: Int,
                                 focusedTextField: FocusState<Int?>.Binding) -> some View {
        self
            .frame(width: customStyle.width, height: customStyle.height)
            .background(
                RoundedRectangle(cornerRadius: customStyle.cornerRadius)
                    .foregroundColor(customStyle.backgroundColor)
                    .border(customStyle.borderColor, width: customStyle.borderWidth)
            )
            .foregroundColor(customStyle.foregroundColor)
            .shadow(
                color: customStyle.shadowColor,
                radius: customStyle.shadowRadius,
                x: customStyle.shadowXOffset,
                y: customStyle.shadowYOffset
            )
            .focused(focusedTextField, equals: index)
            .lineLimit(1)
    }
}
