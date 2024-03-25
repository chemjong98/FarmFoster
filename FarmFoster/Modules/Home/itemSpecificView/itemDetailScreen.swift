//
//  itemDetailScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import AVKit
import WebKit

struct itemDetailScreen: View {
    // MARK: - properties
    @StateObject  var viewModel: ItemDetailViewModel

    init(viewModel: ItemDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            Text( viewModel.disease[0].itemName + " " + "Diseases")
                .font(.custom(AppFont.bold.font, size: 26))
                .foregroundStyle(.navyBlue)

            Divider()
                .frame(height: 2)
                .foregroundStyle(AppColor.appGray.color)
                .offset(y: 8)


            ScrollView(showsIndicators: false) {
                ForEach(viewModel.disease, id: \.self) { disease in
                    diseaseItem(disease: disease)

                    let index = viewModel.disease.count
                    if !(viewModel.disease[index-1] == disease) {
                        Divider()
                            .frame(height: 2)
                            .foregroundStyle(AppColor.appGray.color)
                    } else {
                        if let url = URL(string: "https://www.youtube.com/watch?v=ltRjR_427sY&t=27s") {

                            WebView(url: url)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle(), style: .init())

                                .background {
                                    RoundedRectangle(cornerRadius: 12, style: .circular)
                                        .stroke(AppColor.appGray.color, lineWidth: 2)
                                }
                                .padding(.horizontal, 3)

                        }

                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func diseaseItem(disease: ItemDiseaseModel) -> some View {
        ForEach(disease.itemDisease, id: \.self) { itemDisease in
            HStack {
                VStack(alignment: .leading) {

                    VStack(alignment: .leading){
                        Text("Disease Name:")
                            .font(.custom(AppFont.bold.font, size: 20))

                        Text("\(itemDisease.name)")
                            .font(.custom(AppFont.regular.font, size: 14))
                    }

                    VStack(alignment: .leading) {
                        Text("symptoms:")
                            .font(.custom(AppFont.bold.font, size: 20))

                        ForEach(itemDisease.symptoms, id: \.self) { symptom in
                            Text(symptom)
                                .font(.custom(AppFont.regular.font, size: 14))
                                .multilineTextAlignment(.leading)
                                .padding([.bottom], 2)
                                .padding(.leading, 5)
                        }
                    }

                    VStack(alignment: .leading){
                        Text("solution:")
                            .font(.custom(AppFont.bold.font, size: 20))

                        ForEach(itemDisease.solution, id: \.self) { solution in
                            Text(solution)
                                .font(.custom(AppFont.regular.font, size: 14))
                                .multilineTextAlignment(.leading)
                                .padding([.bottom], 2)
                                .padding(.leading, 5)

                        }
                    }
                }
                .padding(.bottom, 5)

                Spacer()
            }
        }

    }
}
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

//#Preview {
//    @State var disease = ItemDiseaseModel(id: "asdf", itemName: "", itemDisease: [])
//    itemDetailScreen(viewModel: ItemDetailViewModel(disease: disease) )
//}
