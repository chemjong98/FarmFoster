//
//  CardUpdateView.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 10/05/2024.
//

import SwiftUI
import SwiftData

struct CardUpdateView: View {
    // MARK:  properties
    @Bindable var item: SwiftDataCardModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Update Card Details")
                .font(.custom(AppFont.bold.font, size: 24))
                .padding(.bottom, 16)
            
            
            FTextField(inputText: $item.name, type: .normalText, placeholder: "enter your name", showDropdown: .constant(false), name: "Name")
            
            FTextField(inputText: $item.address, type: .normalText, placeholder: "Enter you address", showDropdown: .constant(false), name: "Address")
            
            HStack {
                FButton(buttonType: .normal, title: "Update Card") {
                    dismiss()
                }
                
                Spacer()
                
                FButton(buttonType: .normal, title: "Cancel") {
                    dismiss()
                }
            }
            
            Spacer()
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    CardUpdateView(item: SwiftDataCardModel(name: "asdfas", address: "asdfasdf"))
}
