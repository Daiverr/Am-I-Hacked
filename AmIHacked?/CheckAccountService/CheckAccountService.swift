//
//  CheckAccountService.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 12.09.2022.
//

import Foundation

protocol CheckAccountService {
    func send(email: String) async throws -> [BreachModel]
}
