//
//  TextFieldsScreen.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 29/04/2024.
//

import SwiftUI

struct TextFieldsScreen: View {
    // MARK: properties
    @StateObject var viewModel: TextFieldsViewModel
    @Environment(\.dismiss) private var dismiss
    @State var scrollViewOffset: CGFloat = 0.0
    @State private var deviceSafearea: CGFloat = 0.0
    @State var hasNotch: Bool = true
    @State private var height: CGFloat = 0.0
    @State var showDropdown: Bool = false
    @State var textFieldsType: TextFieldsType?
    
    
    
    // MARK: init
    init(viewModel: TextFieldsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        
        let standardInsets = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        let topArea = standardInsets.top
        if topArea > 20  {
            hasNotch = true
        } else {
            hasNotch = false
        }
    }
    
    
    // MARK: body
    var body: some View {
//        ZStack {
            ScrollView {
                
                DropDownView(dropdownList: $viewModel.defaultDropDownOption, type: .defaultDropdown, name: "Dropdown", viewModel: viewModel, showDorpdown: $showDropdown)
                .zIndex(1)
                
                FTextField(inputText: $viewModel.normalInputText, type: .normalText, placeholder: "", showDropdown: $showDropdown, name: "Normal", action: {})
                
                FTextField(inputText: $viewModel.normalInputText, type: .normalText, placeholder: "", showDropdown: $showDropdown, name: "Normal", action: {})
                
//                
//                FTextField(inputText: $viewModel.normalInputText, type: .normalText, placeholder: "", showDropdown: $showDropdown, name: "Normal", action: {})
////                
//                FTextField(inputText: $viewModel.normalInputText, type: .normalText, placeholder: "", showDropdown: $showDropdown, name: "Normal", action: {})
////                
//                FTextField(inputText: $viewModel.normalInputText, type: .normalText, placeholder: "", showDropdown: $showDropdown, name: "Normal", action: {})
//                
                Spacer()
            }
            .background(.white)
            .padding(.horizontal)
            .onTapGesture {
                showDropdown = false
            }
            .defaultNavigationBack(title: componentsList.TextFields.key) {
            dismiss()
        }
    }
}



// MARK: normalTextView
struct FTextField: View {
    // MARK: properties
    @Binding private var inputText: String
    @State private var type: TextFieldsType
    @State private var placeholder: String
    @Binding var showDropdown: Bool
    @FocusState var isFocused
    @State private var name: String
    var action: (()-> Void)?
    
    // MARK: init
    init(inputText: Binding<String>, type: TextFieldsType, placeholder: String, showDropdown: Binding<Bool>? = nil,name: String = "", action: (()-> Void)? = nil) {
        self._inputText = inputText
        self.type = type
        self.placeholder = placeholder
        self._showDropdown = showDropdown ?? .constant(false)
        self.name = name
        self.action = action
    }
    
    // MARK: body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text( (name == "") ? type.value.capitalized : name)
                .font(.custom(AppFont.regular.font, size: 16))
            
            TextField("", text: $inputText, prompt: {
                Text(placeholder)
            }())
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .focused($isFocused)
            .autocorrectionDisabled(true)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .overlay(alignment: .trailing) {
                if type == .defaultDropdown || type == .searchableDropdown {
                    Image(systemName: showDropdown && isFocused ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 10, height: 6)
                        .padding()
                        .scaledToFit()
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    self.showDropdown.toggle()
                }
                action?()
            }
            .clipped()
        }
    }
}

struct TapShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path(CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
    }
}


#Preview {
    TextFieldsScreen(viewModel: TextFieldsViewModel())
}
