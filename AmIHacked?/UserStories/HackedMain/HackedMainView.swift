//
//  HackedMainView.swift
//  Am I Hacked?
//
//  Created by PROKHOROV Roman on 11.09.2022.
//

import SwiftUI

struct HackedMainView: View {
    @StateObject private var viewModel: HackedMainViewModel
    @State private var searchText = ""
    @State private var buttonTitle = "Проверить"
    
    init(_ vm: HackedMainViewModel) {
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: .s12) {
                Text("Check if your email is in a data breach")
                    .setLarge(.subheadline)
                ZStack(alignment: .trailing) {
                    TextField(
                        "email",
                        text: $searchText
                    )
                    .textFieldStyle(InputFieldEmailStyle())
                    .keyboardType(.webSearch)
                    
                    Button {
                        Task { await viewModel.fetchBreachs(account: searchText) }
                    } label: {
                        Label("", systemImage:"magnifyingglass")
                            .foregroundColor(Color.glass)
                    }
                    .padding(.horizontal)
                }
                if !viewModel.breachs.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.breachs, id: \.id) { breach in
                                CardView(viewModel, breach: breach)
                                    .padding(.bottom, .s5)
                            }
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
                else {
                    Spacer()
                }
            }
            .padding([.horizontal, .top], .s8)
            .toolbar {
                ToolbarItem {
                    VStack {
                        Text("Am I Hacked?")
                            .setLarge(.largeTitle)
                    }
                    .frame(width: UIScreen.main.bounds.width - .s15, alignment: .leading)
                    .padding(.leading, .s1)
                }
            }
            .background(Color.background, ignoresSafeAreaEdges: .all)
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(Color.background)
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .animation(.easeOut, value: viewModel.breachs)
    }
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HackedMainViewModel(pwndService: PwndInfoService(), imageService: ImageService())
        vm.breachs.append(BreachModel(id: UUID(), name: "CDEK", title: "CDEK", domain: "cdek.ru", breachData: "2022-03-09", addedData: "2022-03-17T06:19:02Z", modifiedDate: "2022-03-17T06:19:02Z", pwnCount: 19218203, description: "In early 2022, a collective known as <a href=\"https://www.bleepingcomputer.com/news/security/ukraine-recruits-it-army-to-hack-russian-entities-lists-31-targets/\" target=\"_blank\" rel=\"noopener\">IT Army whose stated goal is to &quot;completely de-anonymise most Russian users by leaking hundreds of gigabytes of databases&quot;</a> published over 30GB of data allegedly sourced from Russian courier service CDEK. The data contained over 19M unique email addresses along with names and phone numbers. The authenticity of the breach could not be independently established and has been flagged as &quot;unverfieid&quot;.", dataClasses: ["Email addresses", "Names", "Phone numbers"], isVerified: false, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/CDEK.png"))
        vm.breachs.append(BreachModel(id: UUID(), name: "CDEK", title: "CDEK", domain: "cdek.ru", breachData: "2022-03-09", addedData: "2022-03-17T06:19:02Z", modifiedDate: "2022-03-17T06:19:02Z", pwnCount: 19218203, description: "In early 2022, a collective known as <a href=\"https://www.bleepingcomputer.com/news/security/ukraine-recruits-it-army-to-hack-russian-entities-lists-31-targets/\" target=\"_blank\" rel=\"noopener\">IT Army whose stated goal is to &quot;completely de-anonymise most Russian users by leaking hundreds of gigabytes of databases&quot;</a> published over 30GB of data allegedly sourced from Russian courier service CDEK. The data contained over 19M unique email addresses along with names and phone numbers. The authenticity of the breach could not be independently established and has been flagged as &quot;unverfieid&quot;.", dataClasses: ["Email addresses", "Names", "Phone numbers"], isVerified: false, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/CDEK.png"))
        vm.breachs.append(BreachModel(id: UUID(), name: "CDEK", title: "CDEK", domain: "cdek.ru", breachData: "2022-03-09", addedData: "2022-03-17T06:19:02Z", modifiedDate: "2022-03-17T06:19:02Z", pwnCount: 19218203, description: "In early 2022, a collective known as <a href=\"https://www.bleepingcomputer.com/news/security/ukraine-recruits-it-army-to-hack-russian-entities-lists-31-targets/\" target=\"_blank\" rel=\"noopener\">IT Army whose stated goal is to &quot;completely de-anonymise most Russian users by leaking hundreds of gigabytes of databases&quot;</a> published over 30GB of data allegedly sourced from Russian courier service CDEK. The data contained over 19M unique email addresses along with names and phone numbers. The authenticity of the breach could not be independently established and has been flagged as &quot;unverfieid&quot;.", dataClasses: ["Email addresses", "Names", "Phone numbers"], isVerified: false, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/CDEK.png"))
        return HackedMainView(vm)
    }
}
