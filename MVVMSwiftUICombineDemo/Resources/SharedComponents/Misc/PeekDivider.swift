//
//  PeekDivider.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI

struct PeekDivider: View {
    var height: CGFloat = 1
    var color: Color = Color.black
    var body: some View {
        Rectangle().frame(height: height).foregroundColor(color.opacity(0.05))
    }
}


struct PeekDivider_Previews: PreviewProvider {
    static var previews: some View {
        PeekDivider().padding()
            .previewLayout(.sizeThatFits)
    }
}
