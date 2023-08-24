//
//  HackedMainAssembly.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 23.08.2023.
//

import SwiftUI

struct HackedMainAssembly {
    func assemble() -> HackedMainView {
        let viewModel = viewModel()
        return HackedMainView(viewModel)
    }
}

extension HackedMainAssembly {
    private func viewModel() -> HackedMainViewModel {
        let pwndService = PwndInfoService()
        let imageService = ImageService()
        return .init(
            pwndService: pwndService,
            imageService: imageService
        )
    }
}
