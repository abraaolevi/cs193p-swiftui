//
//  Cardify.swift
//  Memorize
//
//  Created by Abraao Levi on 04/04/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var themeColor: Color
    
    // Assignment 2 - Extra Credit 1: Gradient Theme
    var themeColorGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [themeColor, themeColor.opacity(gradientOpacity)]), startPoint: .top, endPoint: .bottom)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(themeColorGradient)
            }
        }
    }
    
    // MARK: - Drawing constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let gradientOpacity: Double = 0.6
}

extension View {
    func cardify(isFaceUp: Bool, themeColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, themeColor: themeColor))
    }
}
