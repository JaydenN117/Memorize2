//
//  ContentView.swift
//  Memorize2
//
//  Created by jayden neal on 12/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View { //some view sorta auto deects return type of view for example if there is text, it will return text
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
//            ForEach(0..<4) { _ in
//                VStack {
//                    ForEach(0..<4) { _ in
//                        //every other card is face up, use index
//                    }
//                }
//            }
            
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false;
    var body: some View {
        ZStack(content: { // vertical stack
            if (isFaceUp) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 4)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
    }
}















#Preview {
    ContentView()
}
