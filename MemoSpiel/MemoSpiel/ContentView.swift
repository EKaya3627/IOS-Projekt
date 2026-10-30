//
//  ContentView.swift
//  MemoSpiel
//
//  Created by Kaya, Erol Can on 30.10.26.
//

import SwiftUI

struct ContentView: View {
    
     let emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]
   //g let emojis = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    @State var kartenZahl = 5
    
    var body: some View {
        VStack {
            ScrollView {
                karten
            }
            Spacer()
            kartenSteuerungView
        }
        .padding()
    }
    
    var kartenSteuerungView: some View {
        HStack {
            kartenErzeuger
            Spacer()
            kartenloescher
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var karten: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<kartenZahl, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var kartenloescher: some View {
        kartenSteuerung(by: -1, symbol: "minus.square.fill")
    }
    
    var kartenErzeuger: some View {
        kartenSteuerung(by: +1, symbol: "plus.square.fill")
    }
    
    @ViewBuilder
    func kartenSteuerung(by offset: Int, symbol: String) -> some View {
        Button(action: {
            kartenZahl += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(kartenZahl + offset < 1 || kartenZahl + offset > emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var istGesichtOben = false
    
    var body: some View {
        ZStack {
            let basis: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            
            Group {
                basis.fill(.white)
                basis.stroke(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(istGesichtOben ? 1 : 0)
            
            basis.fill().opacity(istGesichtOben ? 0 : 1)
        }
        .onTapGesture {
            istGesichtOben.toggle()
        }
    }
}

#Preview {
    ContentView()
}
