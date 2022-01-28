//
//  DefaultHeader.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI

struct DefaultHeader<ActionView>: View where ActionView: View {
    var title: String = String()
    var hideDivider: Bool = false
    var isModal: Bool = false
    var showBack: Bool = true
    var foregroundColor: Color = .black
    var onDismissPressed: (() -> ())? = nil
    var leftView: ActionView?
    var leftAction: (() -> ())?
    
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            ZStack {
                HStack {
                    if showBack {BackButton(onPress: onDismissPressed, isModal: isModal, foregroundColor: foregroundColor)}
                    Spacer()
                    if let leftView = leftView {
                        Button(action: {
                            
                        }) { leftView.onTapGesture {
                            if let action = leftAction {
                                action()
                            }
                        } }
                    }
                }
                Text(title).font(.title2).foregroundColor(foregroundColor)
            }.padding(.bottom, 8)
            if !hideDivider { PeekDivider() }
        }.padding(.horizontal, 8)
    }
}

extension DefaultHeader where ActionView == EmptyView {
    init(
        title: String = String(), hideDivider: Bool = false,
        isModal: Bool = false, foregroundColor: Color = Color.black, showBack: Bool = true,
        onDismissPressed: (() -> ())? = nil
    ) {
        self.title = title
        self.hideDivider = hideDivider
        self.isModal = isModal
        self.foregroundColor = foregroundColor
        self.showBack = showBack
        self.onDismissPressed = onDismissPressed
    }
}
