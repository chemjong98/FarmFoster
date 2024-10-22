//
//  DropdownView.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 10/05/2024.
//

import SwiftUI

// MARK: DropDownView
struct DropDownView: View {
    // MARK: properties
    @Binding var dropdownList: [String]
    @State var type: TextFieldsType
    @State var name: String = ""
    @ObservedObject var viewModel: TextFieldsViewModel
    
    @Binding var showdropdown: Bool
    @State var buttonHeight: CGFloat = .zero
    
    
    // MARK: Dropdown-specific properties
    @FocusState private var isFocused: Bool
    
    init(dropdownList: Binding<[String]>, type: TextFieldsType, name: String, viewModel: TextFieldsViewModel, showDorpdown: Binding<Bool>) {
        self._dropdownList = dropdownList
        self.type = type
        self.name = name
        self.viewModel = viewModel
        self._showdropdown = showDorpdown
    }
    
    var body: some View {
        FTextField(inputText: $viewModel.dropDownInputText, type: .defaultDropdown, placeholder: "name", showDropdown: .constant(false), name: name) {
            
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    DispatchQueue.main.async {
                        showdropdown.toggle()
                    }
                }
        )
        .background {
            GeometryReader { proxy -> Color in
                let frame = proxy.frame(in: .global)
                
                DispatchQueue.main.async {
                    buttonHeight = frame.height
                }
                return Color.white
            }
        }
        .overlay(alignment: .topLeading, content: {
            VStack(spacing: 0) {
                if self.showdropdown {
                    Spacer(minLength: buttonHeight)
                    VStack {
                        searchBar
                            .padding(.top)
                            .onTapGesture {
                                showdropdown = true
                            }
                        
                        optionView
                            .padding(.vertical, 8)
                            .cornerRadius(12)
                            .background(.lightGray)
                            .onAppear {
                                isFocused = true
                            }
                        
                    }
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.lightGray)
                            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 4)
                    )
                }
            }
        })
        .id(name)
        
        
    }
    
    @ViewBuilder
    private var optionView: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.searchedList, id: \.self) { option in
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(option)
                            .frame(height: 40)
                            .padding(.horizontal,8)
                        
                        Divider()
                            .frame(height: 1)
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .background(.lightGray)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("tapped")
                        viewModel.dropDownInputText = option
                        viewModel.searchText = ""
                        showdropdown = false
                    }
                }
            }
        }
        .frame(height: viewModel.searchedList.count >= 5 ? 200 : CGFloat(viewModel.searchedList.count * 40))
        
        
        
    }
    
    
    @ViewBuilder
    private var searchBar: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .foregroundStyle(.appOrange)
                .padding(.horizontal, 8)
            
            TextField(text: $viewModel.searchText, label: {
                Text("Search")
                    .font(.custom(AppFont.regular.font, size: 16))
                
            })
            .focused($isFocused)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.vertical, 10)
            
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.appOrange)
                .padding(.horizontal, 8)
                .onTapGesture {
                    viewModel.searchText = ""
                }
            
        }
        .background {
            Color.lightGray
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.appGray, lineWidth: 1)
        }
        .clipped()
    }
}
//#Preview {
//    DropdownView(dropdownList: <#Binding<[String]>#>, type: <#TextFieldsType#>, name: <#String#>, viewModel: <#TextFieldsViewModel#>, showDorpdown: <#Binding<Bool>#>)
//}
