//
//  PwndInfoServiceImpl.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 21.09.2022.
//


import SwiftUI

actor PwndInfoService: IPwndInfoService {
    func perform(url: Service, account: String) async throws -> [BreachModel] {
        guard let url = URL(string: "\(url.rawValue)\("daiverr1@gmail.com")?truncateResponse=false") else { throw ApiServiceError.unknownURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("", forHTTPHeaderField: "hibp-api-key")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([BreachModel].self, from: data)
    }
}
