//
//  CustomButton.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 25/04/2024.
//

import SwiftUI

enum ButtonType {
    case normal
    case withImage
}

struct FButton: View {
    @State var buttonType: ButtonType
    @State var title: String
    @State var image: Image?
    var action: (()-> Void)?
    
    init(buttonType: ButtonType, title: String, image: Image? = nil, action: ( () -> Void)? = nil) {
        self.buttonType = buttonType
        self.title = title
        self.image = image
        self.action = action
    }
    var body: some View {
        switch buttonType {
        case .normal:
            normalButton
        case .withImage:
            ButtonWithImage
        }
    }
    
    @ViewBuilder
    private var normalButton: some View {
       Button(action: {
           action?()
       }, label: {
           Text(title)
               .font(.custom(AppFont.regular.font, size: 16))
               .foregroundColor(Color.gray)
               .padding(.vertical, 6)
               .padding(.horizontal, 4)
       })
    }
    
    @ViewBuilder
    private var ButtonWithImage: some View {
        Button(action: {
            action?()
        }, label: {
            image
        })
    }
}

#Preview {
    FButton(buttonType: .normal, title: "button")
}
