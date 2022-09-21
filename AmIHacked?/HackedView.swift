//
//  ContentView.swift
//  Am I Hacked?
//
//  Created by PROKHOROV Roman on 11.09.2022.
//

import SwiftUI

struct HackedView: View {
    @StateObject private var viewModel = HackedViewModel()
    @State private var searchText = ""
    @State private var buttonTitle = "Проверить"
    
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
                        
                        Button(action: { print("magnifyingglass") }) {
                            Label("", systemImage:"magnifyingglass")
                                .foregroundColor(Color.glass)
                            
                        }
                        .padding(.horizontal)
                    }
                    Text("all breaches")
                        .setLarge(.title)
                    ForEach(viewModel.breachs, id: \.name) { breach in
                        CardView(breach: breach)
                    }
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
        }.onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(Color.background)
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        HackedView()
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
