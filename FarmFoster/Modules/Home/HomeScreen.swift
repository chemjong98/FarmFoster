//
//  HomeScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

enum farmType {
    case animals
    case plants
}

struct HomeScreen: View {
    // MARK: - properties
    @StateObject var viewModel: HomeScreenViewModel

    // MARK: - init
    init(viewModel: HomeScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - body
    var body: some View {
        ZStack {
            VStack {
                AppImage.homeImg.image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: UIScreen.main.bounds.height*0.354)
                    .scaledToFit()
                    .overlay {
                        Color.black.opacity(0.3)
                    }

                Rectangle()
                    .offset(y: -8)
                    .foregroundStyle(AppColor.bg.color)
            }
            VStack {
                Spacer()
                    .frame(height: UIScreen.main.bounds.height*0.3)

                VStack {
                    Group {
                        HStack {
                            AppImage.logo.image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.all, 8)
                                .background(.white)
                                .clipShape(Circle())

                            Text("FarmFoster")
                                .font(.custom(AppFont.bold.font, size: 22))
                                .foregroundStyle(AppColor.appGray.color)

                            Spacer()
                        }

                        filterTab(selection: $viewModel.selection)

                        FarmItemListScreen(viewModel: viewModel, selectionType: $viewModel.selection)

                    }
                    .padding(.all, 16)

                    Spacer()
                }
                .background(.ultraThinMaterial)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )

            }
            .zIndex(1.0)
        }
        .ignoresSafeArea()
    }

    // MARK: - filterTab
    @ViewBuilder
    func filterTab(selection: Binding<farmType>) -> some View {
        HStack {
            VStack(spacing: 4) {
                HStack {
                    HStack {
                        Spacer()
                        Text("Plants")
                            .font(.custom(AppFont.regular.font, size: 18))
                            .foregroundStyle((selection.wrappedValue == .plants) ? AppColor.appOrange.color : AppColor.appGray.color)
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation(.smooth) {
                            viewModel.selection = .plants
                        }
                    }
                    .overlay(alignment: .bottom) {
                        if (selection.wrappedValue == .plants) {
                            RoundedRectangle(cornerRadius: 0)
                                .offset(y: 5)
                                .frame(height: 2)
                                .foregroundStyle((selection.wrappedValue == .plants) ? AppColor.appOrange.color : AppColor.appGray.color)
                        }
                    }


                    HStack {
                        Spacer()
                        Text("Animals")
                            .font(.custom(AppFont.regular.font, size: 18))
                            .foregroundStyle((selection.wrappedValue == .animals) ? AppColor.appOrange.color : AppColor.appGray.color)
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            viewModel.selection = .animals
                        }
                    }
                    .overlay(alignment: .bottom) {
                        if selection.wrappedValue == .animals {
                            RoundedRectangle(cornerRadius: 0)
                                .offset(y: 5)
                                .frame(height: 2)
                                .foregroundStyle((selection.wrappedValue == .animals) ? AppColor.appOrange.color : AppColor.appGray.color)
                        }
                    }

                }
                Divider()
            }
        }
    }
}

#Preview {
    HomeScreen(viewModel: HomeScreenViewModel(networkClient: NetworkClient()))
}
