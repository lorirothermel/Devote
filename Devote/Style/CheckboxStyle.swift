//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Lori Rothermel on 6/23/23.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }  // .onTapGesture
            configuration.label
            
        }  // HStack
    }  // func makeBody
    
    
}  // CheckboxStyle


struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
