//
//  ContentView.swift
//  Memorize2
//
//  Created by jayden neal on 12/24/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","🕷","😈","🦇","🦈","💩","👑","🎩","🕶","👓","🐶","🐱","🐭","🐹"]
    
    @State var cardCount: Int = 2
    
    //goal is keep structs below 12 lines most of the time
    var body: some View { //some view sorta auto deects return type of view for example if there is text, it will return text
        VStack {
            ScrollView{
                cards
            }
            
            Spacer()
            cardCountAdjusters
        }
        
        .padding()
    }
    var cards: some View {
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 120 ))]) { //return actually isnt needed if one line
            ForEach(0..<cardCount, id:\.self) { index in
                CardView(content:emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
            
        }.foregroundColor(.orange) //this all is considered one line

    }
    //by is the external name, offset is the internal name, symbol is same for both
    func cardCountAdjuster(by offset: Int, symbol:String) -> some View {
        Button(action:{
                cardCount += offset
        }, label : {
            Image(systemName: symbol)
                .imageScale(.large)
                .font(.largeTitle)
        }).disabled(cardCount+offset < 1 || cardCount+offset > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack(){ // vertical stack
            let base = RoundedRectangle(cornerRadius: 12) //let means constant
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
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
