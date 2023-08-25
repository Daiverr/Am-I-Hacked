//
//  SwiftyTranslate.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 24.08.2023.
//

import SwiftyTranslate

extension SwiftyTranslate {
    public static func translate(text: String, from: String, to: String) async throws -> Translation {
        try await withCheckedThrowingContinuation({ continuation in
            SwiftyTranslate.translate(text: text, from: from, to: to) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
