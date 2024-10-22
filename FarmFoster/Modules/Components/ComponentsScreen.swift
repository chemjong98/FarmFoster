//
//  ComponentsScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 31/01/2024.
//

import SwiftUI

struct ComponentsScreen: View {
    // MARK: - properties
    @StateObject private var viewModel: ComponentsViewModel
    @State private var showPickerSelector = false
    @State private var mediaPickerFrame: CGRect?
    @State private var deviceSafearea: CGFloat = 0.0
    init(viewModel: ComponentsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(LocalizedString.componentList.key)
                    .font(.custom(AppFont.bold.font, size: 28))
                    ForEach(componentsList.allCases, id: \.self) { item in
                        listItemView(item: item)
                            .frame(height:  30)
                            .padding(.bottom, 8)
                    }
                    
                    Spacer()
                
            }
            .background(Color.white)
            .padding(.vertical, 0)
            .padding(.horizontal, 16)
            .onTapGesture {
                if showPickerSelector {
                    showPickerSelector.toggle()
                }
            }
            
            if showPickerSelector {
                VStack {
                    HStack {
                        Spacer()
                        mediaPickerOption
                            .offset(y: (mediaPickerFrame?.origin.y ?? 0) - (deviceSafearea) + 30)
                            .padding(.trailing, 18)
                    }
                    Spacer()
                }
                
            }
        }
        .onAppear {
            let standardInsets = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
            let topArea = standardInsets.top
            deviceSafearea = topArea
            print(deviceSafearea)
            
//            viewModel.goToTextFields()
        }
    }

    // MARK: - listItemView
    func listItemView(item: componentsList) -> some View {
        GeometryReader {geometry in
            HStack(alignment: .center) {
                Text(item.key.capitalized)
                    .padding(.vertical, 8)
                Spacer()
                
                if item == .mediaPicker {
                    Text("mutiple ios 14+")
                        .padding(.trailing)
                } else if item == .slider {
                    Text("ios 13+")
                        .padding(.trailing)
                } else if item == .swiftDataCards {
                    Text("ios 17+")
                        .padding(.trailing)
                }
                    
            }
            .padding(.leading, 8)
            .background(AppColor.lightGray.color)
            .onAppear {
                if item == .mediaPicker {
                    let frame = geometry.frame(in: .named("mediaPicker"))
                    self.mediaPickerFrame = frame
                    print(frame.height)
                    print(frame.origin.y)
                }
            }
            .onTapGesture {
                viewModel.selectedItem = item
                if item != .mediaPicker {
                    if showPickerSelector {
                        showPickerSelector = false
                    }
                }
                switch item {
                case .map:
                    viewModel.goTomap()
//                                    showPickerSelector.toggle()
                case .shader:
                    viewModel.goToShader()
                case .carousel:
                    viewModel.goTomap()
                case .mediaPicker:
                    showPickerSelector.toggle()
                case .TextFields:
                    viewModel.goToTextFields()
                case .swiftDataCards:
                    viewModel.goTocards()
                case .slider:
                    viewModel.goToSlider()
                }
            }
        }
    }
    
    @ViewBuilder
    private var mediaPickerOption: some View {
        VStack(alignment: .leading, spacing: 0) {
            FButton(buttonType: .normal, title: "singleImage") {
                viewModel.goToMediaPicker()
                showPickerSelector = false
            }

            FButton(buttonType: .normal, title: "MultipleImage"){
                viewModel.goToMediaPickerMultiple()
                showPickerSelector = false
            }
        }
        .padding(.all, 5)
        .background {
            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.gray)
                .foregroundColor(Color.lightGray)
                .shadow(color: .black.opacity(0.4), radius: 7, x: 2, y: 2)
        }
    }
}

//#Preview {
//    ComponentsScreen()
//}
