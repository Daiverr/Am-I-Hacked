//
//  PwndInfoService.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 21.09.2022.
//

import Foundation
import SwiftUI

protocol ApiService {
    func perform(url: Service, account: String) async throws-> [BreachModel]
    //func loadImage(url: String) async -> Image
}

enum Service: String {
    case account = "https://haveibeenpwned.com/api/v3/breachedaccount/"
}

enum ApiServiceError: Swift.Error {
    case unknownURL
}
