//
//  AppButton.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI

struct AppButton: View {
    var title: String
    var foreground: Color = .white
    var background: Color?
    var gradientBackground = Gradient(colors: [.orange, .pink])
    var size: CGSize = .zero
    var feedback: UINotificationFeedbackGenerator.FeedbackType? = .none
    var action: () -> ()
    var body: some View {
        
        if size != .zero {
            Button(action: {
                if let feedback = feedback {
                    UINotificationFeedbackGenerator().notificationOccurred(feedback)
                }
                    action()
            }, label: {
                Text(title)
            })
            .frame(width: size.width, height: size.height)
            .style(background, getTextColor(), gradient: gradientBackground)
        } else {
            Button(action: {
                if let feedback = feedback {
                    UINotificationFeedbackGenerator().notificationOccurred(feedback)
                }
                action()
            }, label: {
                Spacer()
                Text(title)
                Spacer()
            })
            .padding()
            .style(background, getTextColor(), gradient: gradientBackground)
        }
        
    }
    
    func getTextColor() -> Color {
        if [.orange, .black].contains(background) {
            return .white
        }
        return foreground
    }
    
    
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(title: "Button", action: {})
    }
}


private extension View {
    
    func style(_ bg: Color?, _ fg: Color, gradient: Gradient) -> some View {
        self
            .foregroundColor(fg)
            .background(bg != nil ? LinearGradient(gradient: Gradient(colors: [bg!, bg!]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
            .font(.body)
            .cornerRadius(12)
    }
}

func tapWithHaptic() {
    UINotificationFeedbackGenerator().notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
}
