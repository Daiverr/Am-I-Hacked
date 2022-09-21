//
//  PwndInfoServiceImpl.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 21.09.2022.
//

import SwiftUI

class PwndInfoService: ApiService {
    func perform(url: Service, account: String) async throws -> [BreachModel] {
        guard let url = URL(string: "\(url.rawValue)\(account)") else { throw ApiServiceError.unknownURL }
        let session = URLSession.shared
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([BreachModel].self, from: data)
    }
    
//    func loadImage(url: String) async -> KFImage {
//        //KFImage(URL(string: <#T##String#>))
//    }
    
    
}
