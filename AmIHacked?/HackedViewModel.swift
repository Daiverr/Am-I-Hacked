//
//  HackedViewModel.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 21.09.2022.
//

import Foundation

class HackedViewModel: ObservableObject {
    @Published var breachs: [BreachModel] = Array(repeating: BreachModel(name: "Adobe", title: "Adobe", domain: "adobe.com", breachData: "2013-10-04", addedData: "2013-12-04T00:00Z", modifiedDate: "2022-05-15T23:52Z", pwnCount: 152445165, description: "In October 2013, 153 million Adobe accounts were breached with each containing an internal ID, username, email, <em>encrypted</em> password and a password hint in plain text. The password cryptography was poorly done and many were quickly resolved back to plain text. The unencrypted hints also <a href=\"http://www.troyhunt.com/2013/11/adobe-credentials-and-serious.html\" target=\"_blank\" rel=\"noopener\">disclosed much about the passwords</a> adding further to the risk that hundreds of millions of Adobe customers already faced.", dataClasses: ["Email addresses","Password hints","Passwords","Usernames"], isVerified: true, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/Adobe.png"),  count: 7)
    
    func fetchBreachs(account: String) async {
        let api = PwndInfoService()
        do {
            try breachs = await api.perform(url: .account, account: account)
        } catch {
            print("Error")
        }
    }
}
