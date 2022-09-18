//
//  ContentView.swift
//  Am I Hacked?
//
//  Created by PROKHOROV Roman on 11.09.2022.
//

import SwiftUI

enum Const {
    enum Colors {
        static let background = Color(red: 0.933, green: 0.933, blue: 0.933)
        static let text = Color(red: 0.227, green: 0.247, blue: 0.278)
        static let search = Color(red: 0.839, green: 0.89, blue: 0.886)
        static let glass = Color(red: 0.533, green: 0.569, blue: 0.584)
    }
}

struct MainView: View {
    
    @State private var searchText = ""
    @State private var buttonTitle = "Проверить"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Am I Hacked?")
                .setLarge(.largeTitle)
                .padding(.vertical, 10)
            Text("Check if your email is in a data breach")
                .setLarge(.subheadline)
            ZStack(alignment: .trailing) {
                TextField(
                    "email",
                    text: $searchText
                )
                .foregroundColor(Const.Colors.text)
                .padding()
                .frame(height: 56)
                .background(Const.Colors.search)
                .cornerRadius(16)
                
                Button(action: { print("magnifyingglass") }) {
                    Label("", systemImage:"magnifyingglass")
                        .foregroundColor(Const.Colors.glass)
                    
                }
                .padding(.horizontal)
            }
            
            Text("all breaches")
                .setLarge(.title)
                .padding(.vertical)
            
            ScrollView{
                LazyVStack {
                    ForEach(1...100, id: \.self) {_ in
                       // CardView()
                    }
                }
            }
        }
        .padding([.horizontal, .top], 30)
        .background(Const.Colors.background, ignoresSafeAreaEdges: .all)
    }
}

extension Text {
    func setLarge(_ font: Font) -> Text {
        self.font(font)
            .bold()
            .foregroundColor(Const.Colors.text)
    }
    
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct CardView: View {
    
    private let breach: BreachModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(breach.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
            
            Spacer()
            
//            Image(image)
//                .resizable()
//                .renderingMode(.original)
//                .scaledToFit()
//                .frame(width: 250, height: 200)
//                .padding(.bottom, 20)
        }
        .background(Const.Colors.text)
        .cornerRadius(16)
        .frame(width: 138, height: 160)
    }
}
