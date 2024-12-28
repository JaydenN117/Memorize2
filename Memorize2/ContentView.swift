//
//  ContentView.swift
//  Memorize2
//
//  Created by jayden neal on 12/24/24.
//

import SwiftUI

enum Themes {
    case halloween
    case winter
    case summer
}
let emojisHalloween: Array<String> = ["👻","🎃","🕷","😈","🦇","🦈","💩","👑","🎩","🕶","👓","🐶","🐱","🐭","🐹"]
let emojisWinter: Array<String> = ["❄️","⛄️","🎄","🎅","🤶","🦌","🎁","🕯","🧊","🧤","🧣","🧥","🧦","🎿"]
let emojisSummer: Array<String> = ["🌞","🌴","🌊","🏄","🏖","🍉","🍦","🍹","🏝","🏜"]

struct ContentView: View {
    @State var themeState: Themes = .halloween //This manages state, alternatively could of had separate emoji and color states
    
    var body: some View { //some view sorta auto deects return type of view for example if there is text, it will return text
        VStack {
            Text("Memorize!").font(.largeTitle) //Title
            ScrollView{ //Scrollable cards
                cards //cards view
            }
            Spacer() //spacer to move theme changer to bottom
            themeChanger() //theme change buttons
                
        }.padding() //default padding
    }
    
    var cards: some View {
        let (emojis,cardColor) = switch themeState {
            case .halloween:
                (emojisHalloween,Color.orange)
            case .winter:
                (emojisWinter, Color.blue)
            case .summer:
                (emojisSummer, Color.green)
        }
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 80 ))]) { //return actually isnt needed if one line
            
            let shuffledEmojis = emojis.shuffled() // shuffle the deck
            ForEach(0..<shuffledEmojis.count, id:\.self) { index in
                CardView(content:shuffledEmojis[index]).aspectRatio(2/3,contentMode: .fit)
            }
        }.foregroundColor(cardColor) //this all is considered one line
    }
    func themeChanger() -> some View {
        return HStack {
            //Make button for all available themes
            themeButton(.halloween)
            Spacer()
            themeButton(.summer)
            Spacer()
            themeButton(.winter)
            
        }
    }
    func themeButton(_ themeToChangeTo: Themes)-> some View {
        let isCurrentTheme = themeState == themeToChangeTo
        let (label,symbol: symbol) = switch themeToChangeTo { //tuple so I can add a image too
        case .halloween:
            ("Halloween", symbol: "exclamationmark.triangle.fill")
        case .summer:
            ("Summer","sun.max")
        case .winter:
            ("Winter","snowflake")
            
        }
        return Button(action: {
            themeState = themeToChangeTo
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(label)
            }
        }
        ).foregroundColor(isCurrentTheme ? .orange : .blue).font(.headline)
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
                isFaceUp = !isFaceUp //toggle
            }
        }
        
    }
}

#Preview {
    ContentView()
}
