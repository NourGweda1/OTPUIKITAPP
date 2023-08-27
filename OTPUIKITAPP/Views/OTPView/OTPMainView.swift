//
//  OTPMainView.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import SwiftUI

public struct OTPMainView: View {
    
    // MARK: - Data Variables
    internal var textFieldCount: Int
    @State internal var data: [String] = []
    @State internal var mobileNumber: String
    @FocusState internal var focusedTextField: Int?

    // MARK: - Internal State Variables
    @State internal var lastIndex: Int = 0
    @State private var isViewAppeared: Bool = false

    // MARK: - Style Variables
    internal var customStyle: CustomStyle

    // MARK: - Callback Closures
    internal var onChangeCallback: ((String) -> Void)?
    internal var onCompleteCallback: ((String) -> Void)

    // MARK: - StateObjects Variables
    @StateObject internal var otpHandler = OTPHandler()
        
        public init(textFieldCount: Int,
                    customStyle: CustomStyle,
                    mobileNumber: String,
                    onChangeCallback: ((String) -> Void)? = nil,
                    onCompleteCallback: @escaping ((String) -> Void)) {
            self.textFieldCount = textFieldCount
            self.customStyle = customStyle
            self.mobileNumber = mobileNumber
            self.onChangeCallback = onChangeCallback
            self.onCompleteCallback = onCompleteCallback
        }
    
    public var body: some View {
        HStack(alignment: customStyle.hstackAlignment,
               spacing: customStyle.hstackSpacing) {
            ForEach(data.indices, id: \.self) { index in

                EnhancedTextField(data: $data,
                                  currentIndex: .constant(index),
                                  text: $data[index],
                                  font: customStyle.fontStyle,
                                  fontColor: UIColor(customStyle.foregroundColor),
                  onBackspace: { isEmpty in
                    handleOnBackAction(isEmpty: isEmpty, index: index)
                },onChange: { newValue in
                    handleOnChangeAction()
                })
                .customTextFieldModifier(customStyle: customStyle, index: index, focusedTextField: $focusedTextField)
            }
        } .onAppear {
            if !isViewAppeared {
                setUpData()
                isViewAppeared.toggle()
            }
        }
        .onTapGesture {
            focusedTextField = getFocusedTextField()
        }
        .onTapGesture(count: 2) {
            focusedTextField = data.firstIndex(where: { $0.isEmpty }) ?? (data.count - 1)
        }
        .onChange(of: focusedTextField) { newValue in
            guard let newValue else { return }
            handleOnChangeFocus(newValue: newValue)
        }
    }
    
}

