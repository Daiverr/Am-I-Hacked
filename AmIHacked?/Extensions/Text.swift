//
//  Text.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 19.09.2022.
//
import SwiftUI

extension Text {
    func setLarge(_ font: Font) -> Text {
        self.font(font)
            .bold()
            .foregroundColor(Color.text)
    }
    
}
