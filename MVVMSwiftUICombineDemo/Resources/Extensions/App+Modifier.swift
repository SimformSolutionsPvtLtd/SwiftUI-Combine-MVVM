//
//  App+Modifier.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI


extension View {
    
    func loading(show: Bool) -> some View {
        ZStack {
            self
                .disabled(show)
            if show {
                withAnimation {
                ProgressView()
                    .padding(32)
                    .background(Color.gray.opacity(0.7))
                    .cornerRadius(32)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, y: 8.0)
                }
            }
            
        }
    }
    
    func rawLoading(show: Bool) -> some View {
        ZStack {
            
                self
                    .disabled(show)
                if show {
                    withAnimation {
                        ProgressView()
                    }
                }
        }
    }
    
    func genreStyle() -> some View {
        self
            .font(.body)
            .foregroundColor(.black)
        .padding(.vertical, 8).padding(.horizontal)
        .background(.gray)
        .cornerRadius(8)
        .lineLimit(2)
    }

    
    
    //MARK: - BUTTONS
    
    //MARK: - SHAPE
    public func roundedBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat = 6) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
    
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    //MARK: - OVERLAY
    public func gradientForeground(colors: [Color]) -> some View {
            self.overlay(LinearGradient(gradient: .init(colors: colors),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing))
                .mask(self)
        }

}




struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
