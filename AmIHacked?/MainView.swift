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
    var body: some View {
        VStack {
            ZStack {
                
                Image("wallpaper")
                    .resizable()
                    .opacity(0.3)
                    .cornerRadius(30)
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    Text("Test")
                        .font(.largeTitle)
                        .bold()
                        .frame(width: nil, height: nil, alignment: .leading)
                    Spacer()
                    TextField(
                        "email",
                        text: $searchText
                    )
                    .padding()
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.gray, lineWidth: 4)
                    )
                    .cornerRadius(10)
                    Button(action: { print("Button")} ) {
                        Text(buttonTitle)
                    }
                    .buttonStyle(FindButtonStyle())
                    Spacer()
                }
                .padding()
                //.navigationBarTitle(Text("Am I Hacked?"))
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: { print("d") }) {
//                            Label("", systemImage: "line.3.horizontal")
//                                .colorMultiply(.black)
//                        }
//                    }
//                }
            }
            .ignoresSafeArea()
        }
//        ScrollView(.horizontal, showsIndicators: false) {
//            Spacer()
//            HStack {
//                CardView()
//                    .shadow(color: .gray, radius: 8, x: 2, y: 2)
//                    .opacity(0.8)
//                    .padding()
//                CardView()
//                    .shadow(color: .gray, radius: 8, x: 2, y: 2)
//                    .opacity(0.8)
//                    .padding()
//                CardView()
//                    .shadow(color: .gray, radius: 8, x: 2, y: 2)
//                    .opacity(0.8)
//                    .padding()
//            }
//        }
    }
    
    struct FindButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding()
                .foregroundColor(configuration.isPressed ? .clear : .white)
                .font(.body.bold())
                .background(.black)
                .cornerRadius(16)
                .overlay {
                    if configuration.isPressed {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                    }
                }
        }
        
    }
    
    struct CardView: View {
        //let card: Card
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.green)
                VStack {
                    Text("dsdsd")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    Text("dsdsds")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
//            .frame(width: 350, height: 450)
        }
    }
    
}

struct Previews_MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
