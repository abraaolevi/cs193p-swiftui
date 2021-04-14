//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Abraao Levi on 23/03/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .foregroundColor(viewModel.color)
                
                Text(viewModel.score)
                    .padding()
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .navigationBarTitle(Text(viewModel.name), displayMode: .large)
            .toolbar {
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    
    // MARK: - Drawing constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
