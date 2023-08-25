//
//  AsyncTranslateText.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 24.08.2023.
//

import SwiftUI
import SwiftyTranslate

struct AsyncTranslateText: View {
    @State private var text: String
    
    init(_ text: String) {
        _text = State(initialValue: text)
    }
    var body: some View {
        Text(text)
            .onAppear {
                print("onAppear")
                Task.detached(priority: .medium)  {
                    let description = try await SwiftyTranslate.translate(
                        text: text, from: "en", to: "ru"
                    )
                    await MainActor.run { text = description.translated }
                }
            }
    }
}

struct AsyncTranslateText_Previews: PreviewProvider {
    static var previews: some View {
        AsyncTranslateText("Hello, World")
    }
}
