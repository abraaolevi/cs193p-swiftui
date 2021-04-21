//
//  Cardify.swift
//  Memorize
//
//  Created by Abraao Levi on 04/04/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    private var rotation: Double
    private var themeColor: Color
    
    init(isFaceUp: Bool, themeColor: Color) {
        rotation = isFaceUp ? 0 : 180
        self.themeColor = themeColor
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    // Assignment 2 - Extra Credit 1: Gradient Theme
    var themeColorGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [themeColor, themeColor.opacity(gradientOpacity)]), startPoint: .top, endPoint: .bottom)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
                
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(themeColorGradient)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
