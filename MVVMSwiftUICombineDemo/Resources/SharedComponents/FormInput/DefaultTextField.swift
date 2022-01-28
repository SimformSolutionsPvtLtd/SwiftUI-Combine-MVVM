//
//  DefaultTextField.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI

struct DefaultTextField: View {
    var title: String?
    var placeholder: String = String()
    var icon: String?
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var showEyeToggle: Bool
    
    
    @Binding var value: String
    @Binding var isEditable: Bool
    @Binding var isInvalid: Bool
    @State var showPassword: Bool = false
    
    init(title: String? = .none, placeholder: String = String(), icon: String? = .none, isSecure: Bool = false, value: Binding<String>,
         keyboardType: UIKeyboardType = .default, isEditing: Binding<Bool> = .constant(true), isInvalid: Binding<Bool> = .constant(false)) {
        self.title = title
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        self._value = value
        self.keyboardType = keyboardType
        self._isEditable = isEditing
        self.showEyeToggle = isSecure
        self._isInvalid = isInvalid
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            HStack {
                if let icon = icon {
                    Image(icon)
                }
                if isSecure && !showPassword {
                    SecureField(placeholder, text: $value)
                        .disabled(!isEditable)
                } else {
                    TextField(placeholder, text: $value)
                        .disabled(!isEditable)
                        .keyboardType(keyboardType)
                }
                
                if showEyeToggle {
                    Button(action: {
                        showPassword.toggle()
                        UIImpactFeedbackGenerator().impactOccurred()
                    }, label: {
                        Image(showPassword ? "eye-toggle-show" : "eye-toggle-hide")
                    })
                }
            }
            .font(.title3)
            .frame(height: 56)
            .padding(.horizontal)
            .background(Color(UIColor.lightGray).opacity(0.7))
            .cornerRadius(8)
            .roundedBorder(Color.pink, width: isInvalid ? 1.5 : 0, cornerRadius: 8)
        }
        .padding(.vertical, 4)
    }
}

struct DefaultTextField_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTextField(title: "Label", placeholder: "Placeholder", icon: "user", value: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}

