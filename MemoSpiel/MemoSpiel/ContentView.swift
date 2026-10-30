import SwiftUI

struct ContentView: View {
    let fahrzeugeEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐"]
    let naturEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    let menschenEmojis = ["😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃"]

    @State private var aktuelleEmojis: [String] = []
    @State private var aktuelleFarbe: Color = .red
    var body: some View {
        VStack {
            Text("Memospiel!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            ScrollView {
                let minWidth = widthThatBestFits(cardCount: aktuelleEmojis.count)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth))]) {
                    ForEach(aktuelleEmojis.indices, id: \.self) { index in
                        KartenAnsicht(inhalt: aktuelleEmojis[index], kartenFarbe: aktuelleFarbe)
                    }
                }
                .padding()
            }

            Spacer()

            HStack(spacing: 30) {
                themenButton(titel: "Fahrzeuge", systemBild: "car.fill", emojis: fahrzeugeEmojis, farbe: .blue)
                themenButton(titel: "Natur", systemBild: "leaf.fill", emojis: naturEmojis, farbe: .green)
                themenButton(titel: "Menschen", systemBild: "person.fill", emojis: menschenEmojis, farbe: .orange)
            }
            .padding(.bottom)
        }
        .padding()
    }

    
    @ViewBuilder
    func themenButton(titel: String, systemBild: String, emojis: [String], farbe: Color) -> some View {
        Button(action: {
            //zufällige Anzahl von Paaren (mindestens 2 bis maximal Array-Länge)
            let anzahlPaare = Int.random(in: 2...emojis.count)
            let auswahl = Array(emojis.prefix(anzahlPaare))
            
            // Paare bilden (2x gleiches Emoji) und per .shuffled() zufällig mischen
            aktuelleEmojis = (auswahl + auswahl).shuffled()
            aktuelleFarbe = farbe
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemBild)
                    .font(.largeTitle)
                Text(titel)
                    .font(.caption)
            }
        }
    }

    //Kartenbreite in Abhängigkeit von der Gesamtanzahl der Karten
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount > 16 {
            return 60
        } else if cardCount > 8 {
            return 75
        } else {
            return 95
        }
    }
}


struct KartenAnsicht: View {
    let inhalt: String
    let kartenFarbe: Color
    @State private var istDeutlichOeffentlich: Bool = false

    var body: some View {
        ZStack {
            let basis = RoundedRectangle(cornerRadius: 12)
            if istDeutlichOeffentlich {
                basis.fill(.white)
                basis.strokeBorder(lineWidth: 3).foregroundColor(kartenFarbe)
                Text(inhalt).font(.largeTitle)
            } else {
                basis.fill(kartenFarbe) // Verdeckte Karte zeigt die Themenfarbe
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            istDeutlichOeffentlich.toggle()
        }
    }
}

#Preview {
    ContentView()
}
