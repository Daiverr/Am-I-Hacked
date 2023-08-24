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
            ScrollView(.vertical) {
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
                    Text("all breaches")
                        .setLarge(.title)
                    ForEach(viewModel.breachs, id: \.id) { breach in
                        CardView(
                            viewModel: viewModel,
                            breach: breach
                        )
                    }
                    .transition(.move(edge: .bottom))
                }
                .padding([.horizontal, .top], .s15)
            }
            .toolbar {
                ToolbarItem {
                    VStack {
                        Text("Am I Hacked?")
                            .setLarge(.largeTitle)
                    }
                    .frame(width: UIScreen.main.bounds.width - .s15, alignment: .leading)
                    .padding(.leading, .s15)
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
        .animation(.easeInOut, value: viewModel.breachs)
    }
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        HackedMainView(.init(pwndService: PwndInfoService(), imageService: ImageService()))
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
    @ObservedObject var viewModel: HackedMainViewModel
    let breach: BreachModel
    @State private var image: UIImage = .init()
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: .s8)
                .foregroundColor(Color(uiColor: image.averageColor ?? .white).opacity(0.4))
                .saturation(5)
            HStack {
                VStack(alignment: .leading) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80, alignment: .leading)
                        .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                    Spacer()
                    Text(breach.domain.isEmpty ? breach.name : breach.domain)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                }
                Spacer(minLength: .s15)
                VStack(alignment: .trailing) {
                    Text(removeHyperlinks(from: breach.description))
                        .lineLimit(3)
                        .font(.footnote)
                        .foregroundColor(Color.glass)
                        .padding(.all, .s5)
                        .background(Color.search.cornerRadius(.s5))
                    Spacer()
                    Button(action: {}) {
                        Text("more...")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.glass)
                            .padding(.vertical,6)
                            .padding(.horizontal,25)
                            .background(Color.search)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.all)
        }
        .onAppear {
            Task {
                let image = await viewModel.getImage(from: breach.logoPath)
                await MainActor.run { self.image = image }
            }
        }
    }
    
    func removeHyperlinks(from string: String) -> String {
        var modifiedString = string
            
        // Remove hyperlinks
        let regex = try! NSRegularExpression(pattern: "<a[^>]*>(.*?)</a>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: modifiedString.utf16.count)
        modifiedString = regex.stringByReplacingMatches(in: modifiedString, options: [], range: range, withTemplate: "$1")
        
        // Replace &quot; with real quotation mark
        modifiedString = modifiedString.replacingOccurrences(of: "&quot;", with: "\"")
        
        return modifiedString
    }
}
