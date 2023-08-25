//
//  CardView.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 24.08.2023.
//

import SwiftUI
import SwiftyTranslate

struct CardView: View {
    private enum Size {
        case small, expand
    }
    @Namespace private var animation
    @ObservedObject private var viewModel: HackedMainViewModel
    @State private var image: UIImage = .init()
    @State private var isSmall: Bool = true
    @State private var averageColor: UIColor = .lightGray
    private let breach: BreachModel
    
    init(_ vm: HackedMainViewModel, breach: BreachModel) {
        viewModel = vm
        self.breach = breach
    }
    
    var body: some View {
        VStack {
            if isSmall {
                HStack(spacing: .zero) {
                    image(size: .small)
                    ZStack {
                        whiteRectangle(size: .small)
                        VStack(alignment: .leading, spacing: .s3) {
                            breachTitle(size: .small)
                            Text(breach.breachData.toDate()!.toString(format: .dateShortTitleWithYear))
                                .matchedGeometryEffect(id: "date", in: animation)
                            descriptionText(size: .small)
                                .padding(.top)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 120, alignment: .leading)
                }
                .padding(.horizontal, .s3)
                .frame(height: 150)
                .cornerRadius(.s8)
                .background(Color.background)
            } else {
                ZStack(alignment: .top) {
                    rectangle
                    VStack(alignment: .leading) {
                       HStack {
                           image(size: .expand)
                           Spacer()
                           VStack {
                               breachTitle(size: .expand)
                               Spacer()
                               domainName
                           }
                       }
                       .padding()
                       .frame(height: 80)
                        
                       ZStack(alignment: .topLeading) {
                           whiteRectangle(size: .expand)
                           VStack(alignment: .leading, spacing: .s3) {
                               Text("About")
                                   .font(.headline)
                               descriptionText(size: .expand)
                               Text("Leaked")
                                   .font(.headline)
                               ForEach(breach.dataClasses, id: \.self) { data in
                                   AsyncTranslateText(data)
                                       .font(.footnote)
                                       .padding(.bottom,.s1)
                               }
                           }
                           .padding(.s8)
                       }
                   }
               }
                .cornerRadius(.s8)
            }
        }
        .onAppear {
            Task.detached(priority: .userInitiated) {
                let image = await viewModel.getImage(from: breach.logoPath)
                await MainActor.run { self.image = image }
                Task.detached(priority: .high) {
                    let color = await image.averageColor()
                    await MainActor.run { self.averageColor = color ?? .lightGray }
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeOut) {
                isSmall.toggle()
            }
        }
        .animation(.easeInOut, value: averageColor)
    }
    
    private var rectangle: some View {
        RoundedRectangle(cornerRadius: .s8)
            .foregroundColor(Color(uiColor: averageColor).opacity(0.4))
            .saturation(5)
            .matchedGeometryEffect(id: "color", in: animation)
    }
    
    private var domainName: some View {
        Text(breach.domain.isEmpty ? breach.name : breach.domain)
            .font(.subheadline)
            .bold()
            .foregroundColor(.white)
            .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
            .matchedGeometryEffect(id: "date", in: animation)
    }
    
    private var logo: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(color: .glass.opacity(0.7),radius: 1, x: 1, y: 1)
            .matchedGeometryEffect(id: "Image", in: animation, anchor: .topLeading)
    }
    
    @ViewBuilder
    private func image(size: Size) -> some View {
        if size == .small {
            logo
                .padding(.horizontal, .s5)
                .frame(width: 150, height: 150)
                .background(
                    Color(uiColor: averageColor)
                        .opacity(0.4)
                        .saturation(5)
                        .matchedGeometryEffect(id: "color", in: animation)
                )
                .cornerRadius(.s8, corners: .allCorners)
                .shadow(color: Color(uiColor: .lightGray).opacity(0.1),radius: 3, x: 5, y: 10)
        } else {
            logo
        }
    }
    
    @ViewBuilder
    private func whiteRectangle(size: Size) -> some View {
        if size == .small {
            Color.white
                .cornerRadius(.s8, corners: [.topRight, .bottomRight])
                .frame(height: 120, alignment: .leading)
                .shadow(color: Color(uiColor: .lightGray).opacity(0.1),radius: 3, x: 5, y: 5)
                .matchedGeometryEffect(id: "whiteRectangle", in: animation)
        } else {
            RoundedRectangle(cornerRadius: .s8)
                .foregroundColor(.white)
                .shadow(radius: .s12, x: -10, y: 0)
                .mask(Rectangle().padding(.top, -100))
                .matchedGeometryEffect(id: "whiteRectangle", in: animation)
        }
    }
    
    @ViewBuilder
    private func descriptionText(size: Size) -> some View {
        if size == .small {
            AsyncTranslateText(breach.description.withoutHyperlinks)
                .lineLimit(1)
                .font(.footnote)
                .foregroundColor(Color.glass)
                .matchedGeometryEffect(id: "description", in: animation)
        } else {
            AsyncTranslateText(breach.description.withoutHyperlinks)
                .font(.footnote)
                .matchedGeometryEffect(id: "description", in: animation, properties: .position)
        }
    }
    
    @ViewBuilder
    private func breachTitle(size: Size) -> some View {
        if size == .small {
            Text(breach.title)
                .font(.title3)
                .bold()
                .matchedGeometryEffect(id: "title", in: animation)
        } else {
            Text(breach.title)
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .shadow(color: .glass.opacity(0.7),radius: 1, x: 0, y: 1)
                .matchedGeometryEffect(id: "title", in: animation)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            .init(
                pwndService: PwndInfoService(),
                imageService: ImageService()
            ),
            breach: BreachModel(id: UUID(), name: "CDEK", title: "CDEK", domain: "cdek.ru", breachData: "2022-03-09", addedData: "2022-03-17T06:19:02Z", modifiedDate: "2022-03-17T06:19:02Z", pwnCount: 19218203, description: "In early 2022, a collective known as <a href=\"https://www.bleepingcomputer.com/news/security/ukraine-recruits-it-army-to-hack-russian-entities-lists-31-targets/\" target=\"_blank\" rel=\"noopener\">IT Army whose stated goal is to &quot;completely de-anonymise most Russian users by leaking hundreds of gigabytes of databases&quot;</a> published over 30GB of data allegedly sourced from Russian courier service CDEK. The data contained over 19M unique email addresses along with names and phone numbers. The authenticity of the breach could not be independently established and has been flagged as &quot;unverfieid&quot;.", dataClasses: ["Email addresses", "Names", "Phone numbers"], isVerified: false, isFabricated: false, isSensitive: false, isRetired: false, isSpamList: false, logoPath: "https://haveibeenpwned.com/Content/Images/PwnedLogos/CDEK.png")
        )
    }
}
