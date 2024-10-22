//
//  SliderScreen.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 06/05/2024.
//

import SwiftUI

struct SliderScreen: View {
    @State var angle: CGFloat = UIScreen.main.brightness
    @Environment(\.dismiss) private var dismiss
    @State private var allow: Bool = false
    var body: some View {
        VStack {
            Toggle(isOn: $allow, label: {
                Text("Activate Slider and indicators?")
            })
            .padding(.vertical)
            
            Text("Rotate Me")
                .font(.custom(AppFont.bold.font, size: 20))
                .foregroundStyle(.appOrange)
                .rotation3DEffect(Angle(degrees: Double(angle)), axis: (x: 0.3, y: 0, z: 0.8), anchor: .bottomLeading, anchorZ: .leastNonzeroMagnitude, perspective: .leastNonzeroMagnitude)
            
            Slider(value: $angle, in: 0...360, step: 1)
                .disabled(allow == true ? false : true)
            
            Text(String(describing: angle))
            
            Stepper("\(String(format: "%.1f", angle)) degree", value: $angle, in: 0...360)
                .disabled(allow == true ? false : true)
            
            Spacer()
        }
        
        .padding(.horizontal, 24)
        .defaultNavigationBack(title: "Slider") {
            dismiss()
        }
    }
}

#Preview {
    SliderScreen()
}
