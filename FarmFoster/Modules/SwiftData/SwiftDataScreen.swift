//
//  SwiftDataScreen.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 02/05/2024.
//

import SwiftUI
import SwiftData

struct SwiftDataScreen: View {
    @State private var performNavigation: Bool = false
    @State private var showUpdate: Bool = false
    @Query private var cards : [SwiftDataCardModel]
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State var performDelete: Bool = false
    @State var selectionIndex: Int?
    
    
    
    @StateObject var viewModel: SwiftDataViewModel
    
    init(viewModel: SwiftDataViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    ForEach(cards.indices, id: \.self) { index in
                        cardView(index: index) {
                            
                        }
                        .onTapGesture {
                            if selectionIndex == index {
                                performDelete.toggle()
                            } else  {
                                performDelete = true
                                selectionIndex = index
                            }
                            
                            
                        }
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                    
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ButtonShape()
                        .fill(Color.appOrange)
                        .frame(width: 60, height: 60)
                        .overlay() {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 18, height: 18)
                            
                        }
                        .onTapGesture {
                            self.performNavigation = true
                        }
                        .fullScreenCover(isPresented: $performNavigation) {
                            if #available(iOS 17.0, *) {
                                AddCardScreen()
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        .fullScreenCover(isPresented: $showUpdate, content: {
                            CardUpdateView(item: viewModel.selectedItem)
                        })
                }
            }
        }
        .padding(.horizontal, 16)
        .defaultNavigationBack(title: "Card List") {
            dismiss()
        }
    }
    
    @ViewBuilder
    private func cardView(index: Int , action: (()->Void)? = nil) -> some View {
        HStack {
            Image("avatar")
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFit()
                .presentationCornerRadius(40)
                .padding([.top, .leading, .bottom])
            
            VStack(alignment: .leading, spacing: 5) {
                Text(cards[index].name)
                    .foregroundStyle(.appGray)
                    .font(.custom(AppFont.bold.font, size: 16))
                
                Text(cards[index].address)
                    .foregroundStyle(.appGray)
                    .font(.custom(AppFont.bold.font, size: 16))
            }
            .padding()
            
            Spacer()
            
            if performDelete && index == selectionIndex {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.appOrange)
                        .onTapGesture(perform: {
                            withAnimation {
                                viewModel.selectedItem = cards[index]
                                showUpdate = true
                                performDelete = false
                            }
                        })
                    
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.appOrange)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            withAnimation {
                                context.delete(cards[index])
                            }
                        }
                }
                .padding(.horizontal, 8)
            }
        }

        .background {
            Color.white
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColor.appOrange.color)
        }
    }
}

struct ButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the shape of the message icon
        let width = rect.width
        let height = rect.height
        let cornerRadius = min(width, height) * 0.1 // Adjust the corner radius as needed
        
        // Start drawing the path
        path.move(to: CGPoint(x: width * 0.2, y: 0))
        path.addLine(to: CGPoint(x: width * 0.8, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: height * 0.2), control: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height * 0.8))
        path.addQuadCurve(to: CGPoint(x: width * 0.8, y: height), control: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width * 0.2, y: height))
//        path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.8))
        path.addQuadCurve(to: CGPoint(x: 0.2, y: height), control: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0.2, y: 0))
        path.addQuadCurve(to: CGPoint(x: width * 0.2, y: 0), control: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        
        return path
    }
}

@available(iOS 17.0, *)
struct AddCardScreen: View {
    @State private  var cardItem = SwiftDataCardModel()
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Add Card Details")
                .font(.custom(AppFont.bold.font, size: 24))
                .padding(.bottom, 16)
            
            
            FTextField(inputText: $cardItem.name, type: .normalText, placeholder: "enter your name", showDropdown: .constant(false), name: "Name")
            
            FTextField(inputText: $cardItem.address, type: .normalText, placeholder: "Enter you address", showDropdown: .constant(false), name: "Address")
            
            HStack {
                FButton(buttonType: .normal, title: "Add Card") {
                    context.insert(cardItem)
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
    SwiftDataScreen(viewModel: SwiftDataViewModel())
}
