//
//  ContentView.swift
//  Am I Hacked?
//
//  Created by PROKHOROV Roman on 11.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @State private var searchText = ""
    @State private var buttonTitle = "Проверить"
    
    @State var stories = [
        BreachModel(name: "Adobe", title: "Adobe", domain: "adobe.com", breachData: "2013-10-04", addedData: "2013-12-04T00:00Z", modifiedDate: "2022-05-15T23:52Z", pwnCount: 152445165, description: "In October 2013, 153 million Adobe accounts were breached with each containing an internal ID, username, email, <em>encrypted</em> password and a password hint in plain text. The password cryptography was poorly done and many were quickly resolved back to plain text. The unencrypted hints also <a href=\"http://www.troyhunt.com/2013/11/adobe-credentials-and-serious.html\" target=\"_blank\" rel=\"noopener\">disclosed much about the passwords</a> adding further to the risk that hundreds of millions of Adobe customers already faced.", dataClasses: ["Email addresses","Password hints","Passwords","Usernames"], isVerified: true, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/Adobe.png")
    ]
    @State var scrolled = 0
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: .s12) {
                Text("Am I Hacked?")
                    .setLarge(.largeTitle)
                    .padding(.vertical, .s5)
                Text("Check if your email is in a data breach")
                    .setLarge(.subheadline)
                ZStack(alignment: .trailing) {
                    TextField(
                        "email",
                        text: $searchText
                    )
                    .textFieldStyle(InputFieldEmailStyle())
                    
                    Button(action: { print("magnifyingglass") }) {
                        Label("", systemImage:"magnifyingglass")
                            .foregroundColor(Color.glass)
                        
                    }
                    .padding(.horizontal)
                }
                Text("all breaches")
                    .setLarge(.title)
                //.padding(.top)
                ForEach(stories, id: \.name) { story in
                    CardView(breach: story)
                }
            }
            .padding([.horizontal, .top], .s15)
        }
        .background(Color.background, ignoresSafeAreaEdges: .all)
    }
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct InputFieldEmailStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(Color.text)
            .padding()
            .frame(height: 56)
            .background(Color.search)
            .cornerRadius(.s8)
        }
}

struct CardView: View {
    
    let breach: BreachModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            Color.text
                .frame(height: (UIScreen.main.bounds.height / 3))
                .cornerRadius(15)
                .shadow(color: Color.background.opacity(0.5), radius: 4, x: 4, y: 4)
            VStack(alignment: .trailing, spacing: 18) {
                HStack{
                    Spacer()
                    Text(breach.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Button(action: {}) {
                    Text("Read Later")
                        .font(.caption)
                        .bold()
                        .foregroundColor(Color.glass)
                        .padding(.vertical,6)
                        .padding(.horizontal,25)
                        .background(Color.search)
                        .clipShape(Capsule())
                }
            }
            .padding([.trailing, .bottom], 20)
        }
    }
}
