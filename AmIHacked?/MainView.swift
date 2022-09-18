//
//  ContentView.swift
//  Am I Hacked?
//
//  Created by PROKHOROV Roman on 11.09.2022.
//

import SwiftUI

enum Const {
    enum Colors {
        static let title = Color(red: 0.227, green: 0.247, blue: 0.278)
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
                .setLarge()
                .padding(.vertical)
            ZStack(alignment: .trailing) {
                TextField(
                    "email",
                    text: $searchText
                )
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
                .font(.title)
                .bold()
                .foregroundColor(Const.Colors.title)
            
            ScrollView{
                LazyVStack {
                    ForEach(1...100, id: \.self) {_ in
                       // CardView()
                    }
                }
            }
            
            //Spacer()
        }
        .padding(30)
    }
}

extension Text {
    func setLarge() -> Text {
        self.font(.largeTitle)
            .bold()
            .foregroundColor(Const.Colors.title)
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
        .background(Const.Colors.title)
        .cornerRadius(16)
        .frame(width: 138, height: 160)
    }
}
