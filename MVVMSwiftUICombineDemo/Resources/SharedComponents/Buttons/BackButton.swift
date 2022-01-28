//
//  BackButton.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var onPress: (() -> ())? = nil
    var isModal: Bool = false
    var foregroundColor: Color = .black
    var body: some View {
        Button(action: {
            if let onPress = onPress {
                onPress()
            }
            presentationMode.wrappedValue.dismiss()
        }, label: {
            if isModal {
                Image(systemName: "multiply").resizable().frame(width: 16, height: 16)
                    .foregroundColor(foregroundColor)
                    .padding(8)
            } else {
                Image(systemName: "chevron.backward")
                    .foregroundColor(foregroundColor)
                    .padding(8)
            }
            
        })
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .previewLayout(.sizeThatFits)
        BackButton()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
