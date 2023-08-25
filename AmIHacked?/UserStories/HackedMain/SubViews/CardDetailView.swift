//
//  CardDetailView.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 24.08.2023.
//

import SwiftUI

struct CardDetailView: View {
    @Namespace private var animation
    @ObservedObject private var viewModel: HackedMainViewModel
    @State private var image: UIImage = .init()
    @State private var isSmall: Bool = true
    private let breach: BreachModel
    
    init(_ vm: HackedMainViewModel, breach: BreachModel) {
        viewModel = vm
        self.breach = breach
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: .s8)
               .foregroundColor(Color(uiColor: image.averageColor ?? .white))
               .saturation(5)
               .matchedGeometryEffect(id: "RoundedRectangle", in: animation)
           VStack(alignment: .leading) {
               HStack {
                   Image(uiImage: image)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 120, height: 120)
                       .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                       .matchedGeometryEffect(id: "Image", in: animation, anchor: .topLeading)
                   Spacer()
                   VStack {
                       Text(breach.name)
                           .font(.subheadline)
                           .bold()
                           .foregroundColor(.white)
                           .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                       Text(breach.domain.isEmpty ? breach.name : breach.domain)
                           .font(.subheadline)
                           .bold()
                           .foregroundColor(.white)
                           .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                           .matchedGeometryEffect(id: "domain", in: animation, properties: .position)
                   }
               }
               
               .padding()
               VStack(alignment: .leading) {
                   ZStack(alignment: .leading) {
                       RoundedRectangle(cornerRadius: .s8)
                           .foregroundColor(.white)
                           .shadow(radius: .s12, x: -10, y: 0)
                           .mask(Rectangle().padding(.top, -100))
                       .matchedGeometryEffect(id: "more", in: animation)
                       VStack(alignment: .leading) {
                           Text("About")
                               .font(.headline)
                           Text(breach.description.withoutHyperlinks)
                               .font(.caption)
                               .matchedGeometryEffect(id: "description", in: animation, properties: .position)
                           Spacer()
                       }
                       .padding(.s8)
                   }
               }
           }
       }
        .onAppear {
            Task {
                let image = await viewModel.getImage(from: breach.logoPath)
                await MainActor.run { self.image = image }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(
            .init(
                pwndService: PwndInfoService(),
                imageService: ImageService()
            ),
            breach: BreachModel(id: UUID(), name: "CDEK", title: "CDEK", domain: "cdek.ru", breachData: "2022-03-09", addedData: "2022-03-17T06:19:02Z", modifiedDate: "2022-03-17T06:19:02Z", pwnCount: 19218203, description: "In early 2022, a collective known as <a href=\"https://www.bleepingcomputer.com/news/security/ukraine-recruits-it-army-to-hack-russian-entities-lists-31-targets/\" target=\"_blank\" rel=\"noopener\">IT Army whose stated goal is to &quot;completely de-anonymise most Russian users by leaking hundreds of gigabytes of databases&quot;</a> published over 30GB of data allegedly sourced from Russian courier service CDEK. The data contained over 19M unique email addresses along with names and phone numbers. The authenticity of the breach could not be independently established and has been flagged as &quot;unverfieid&quot;.", dataClasses: ["Email addresses", "Names", "Phone numbers"], isVerified: false, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/CDEK.png")
        )
    }
}
