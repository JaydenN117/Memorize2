//
//  ContentView.swift
//  Memorize2
//
//  Created by jayden neal on 12/24/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","🕷","😈","🦇","🦈"] //Array<String> equivalent to [String], can also infer

    var body: some View { //some view sorta auto deects return type of view for example if there is text, it will return text
        HStack {
            
            ForEach(emojis.indices, id:\.self) { index in
                CardView(content:emojis[index])
                
            }
            
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack(){ // vertical stack
            let base = RoundedRectangle(cornerRadius: 12) //let means constant
            if (isFaceUp) {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
            } else {
                RoundedRectangle(cornerRadius: 12) //.fill is default
            }
        }
        .onTapGesture {
            print("Tapped")
            //self view cannot be changed (its immutable) so isFaceUp = !isFaceUp wont work
            //For temporary state can use @State in front to create a pointer to a state instead
            isFaceUp = !isFaceUp
        }
    }
        
}















#Preview {
    ContentView()
}
