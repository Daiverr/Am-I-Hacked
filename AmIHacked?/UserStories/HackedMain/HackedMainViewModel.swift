//
//  HackedViewModel.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 21.09.2022.
//

import SwiftUI

final class HackedMainViewModel: ObservableObject {
    private let pwndService: IPwndInfoService
    private let imageService: IImageService
    
    @Published var breachs: [BreachModel] = []
    
    init(
        pwndService: IPwndInfoService,
        imageService: IImageService
    ) {
        self.pwndService = pwndService
        self.imageService = imageService
    }
    
    func fetchBreachs(account: String) async {
        do {
            let response = try await pwndService.perform(url: .account, account: account)
            await MainActor.run { breachs = response }
            response.forEach { breach in
                print(breach.description)
            }
        } catch {
            print(error)
        }
    }
    
    func getImage(from url: String) async -> UIImage {
        await imageService.getImage(from: url) ?? .init()
    }
}
