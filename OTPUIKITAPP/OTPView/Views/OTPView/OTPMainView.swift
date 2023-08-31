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
    @State internal var internalData: [String] = []
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

    // MARK: - Binding Variables
    @Binding var shouldDismissKeyboard: Bool

    // MARK: - StateObjects Variables
    @StateObject internal var otpHandler = OTPHandler()
        
        public init(textFieldCount: Int,
                    customStyle: CustomStyle,
                    mobileNumber: String,
                    onChangeCallback: ((String) -> Void)? = nil,
                    onCompleteCallback: @escaping ((String) -> Void),
                    shouldDismissKeyboard: Binding<Bool>) {
            self.textFieldCount = textFieldCount
            self.customStyle = customStyle
            self.mobileNumber = mobileNumber
            self.onChangeCallback = onChangeCallback
            self.onCompleteCallback = onCompleteCallback
            _shouldDismissKeyboard = shouldDismissKeyboard
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
        }.onChange(of: shouldDismissKeyboard, perform: { newValue in
            if newValue {
                focusedTextField = nil
            }
        }).onChange(of: focusedTextField) { newValue in
            guard let newValue else { return }
            handleOnChangeFocus(newValue: newValue)
        }.onChange(of: data, perform: { newValue in
            if isAllDataFull() {
                lastIndex = data.endIndex
                focusedTextField = nil
            }
        })
    }
}

