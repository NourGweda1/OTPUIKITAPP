//
//  ContentView.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 20/08/2023.
//

import SwiftUI

struct ContentView: View {

    @State var shouldDismissKeyboard: Bool = false

    var body: some View {
        VStack {
            OTPMainView(textFieldCount: 6,
                        customStyle: CustomStyle(foregroundColor: .blue,
                                                 fontStyle: .systemFont(ofSize: 18),
                                                 hstackSpacing: 10,
                                                 borderColor: .blue),
                        mobileNumber: "201206425318",
                        onChangeCallback: { newValue in
                debugPrint(newValue, "On Change Value")
            },          onCompleteCallback: { newValue in
                debugPrint(newValue, "On Back Value")
                shouldDismissKeyboard = true
            },shouldDismissKeyboard: $shouldDismissKeyboard)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
