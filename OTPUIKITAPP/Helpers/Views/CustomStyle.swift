//
//  CustomStyle.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import SwiftUI

public struct CustomStyle {
    var foregroundColor: Color
    var fontStyle: UIFont
    var hstackSpacing: CGFloat
    var hstackAlignment: VerticalAlignment = .center
    var borderColor: Color = .clear
    var width: CGFloat = 50
    var height: CGFloat = 50
    var backgroundColor: Color = .black.opacity(0.5)
    var cornerRadius: CGFloat = 10
    var borderWidth: CGFloat = 2
    var shadowColor: Color = .clear
    var shadowRadius: CGFloat = 0
    var shadowXOffset: CGFloat = 0
    var shadowYOffset: CGFloat = 0
}
