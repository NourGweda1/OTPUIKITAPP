//
//  TrialKeyboardView.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 29/08/2023.
//

import SwiftUI

struct TrialKeyboardView: View {

    @State var text: String = ""

    var body: some View {
        TextField("", text: $text)
            .font(.title.bold())
            .foregroundColor(.blue)
            .onChange(of: text) { newValue in
                debugPrint(newValue, "⌨️")
            }
    }
}

struct TrialKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        TrialKeyboardView()
    }
}
