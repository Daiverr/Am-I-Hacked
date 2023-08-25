//
//  InputFieldEmailStyle.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 24.08.2023.
//

import SwiftUI

struct InputFieldEmailStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(Color.text)
            .padding()
            .frame(height: .s28)
            .background(Color.search)
            .cornerRadius(.s8)
        }
}
