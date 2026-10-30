import SwiftUI

struct ContentView: View {
    // Verschiedene Themen mit jeweils passenden Emojis (paartauglich definiert)
    let transportEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐"]
    let naturEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    let menschenEmojis = ["😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃"]

    // @State-Variable für die aktuell aktiven Karten des gewählten Themas
    @State private var aktuelleEmojis: [String] = []

    var body: some View {
        VStack {
            // 3. Titel "Memospiel!" am oberen Bildschirmrand mit großer Schriftart
            Text("Memospiel!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            ScrollView {
                // Karten-Grid
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(aktuelleEmojis.indices, id: \.self) { index in
                        KartenAnsicht(inhalt: aktuelleEmojis[index])
                    }
                }
                .padding()
            }

            Spacer()

            // 4., 7., 8. Buttons zur Themenauswahl am unteren Rand
            HStack(spacing: 30) {
                themenButton(titel: "Transport", systemBild: "car.fill", emojis: transportEmojis)
                themenButton(titel: "Natur", systemBild: "leaf.fill", emojis: naturEmojis)
                themenButton(titel: "Menschen", systemBild: "person.fill", emojis: menschenEmojis)
            }
            .padding(.bottom)
        }
        .padding()
    }

    // Hilfsfunktion zur Erstellung der Themen-Buttons (Vermeidung von Wiederholungen)
    @ViewBuilder
    func themenButton(titel: String, systemBild: String, emojis: [String]) -> some View {
        Button(action: {
            // 5. & 6. Erzeuge Kartenpaare (2x jedes Emoji) und mische sie zufällig durch
            let anzahlPaare = Int.random(in: 4...emojis.count)
            let auswahl = Array(emojis.prefix(anzahlPaare))
            aktuelleEmojis = (auswahl + auswahl).shuffled()
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemBild)
                    .font(.largeTitle) // Größere Darstellung für das Symbol
                Text(titel)
                    .font(.caption)    // Deutlich kleinere Schriftart für die Beschreibung
            }
        }
    }
}

// Ansicht für eine einzelne Karte (10. Standardmäßig verdeckt)
struct KartenAnsicht: View {
    let inhalt: String
    @State private var istDeutlichOeffentlich: Bool = false // Startet verdeckt (false)

    var body: some View {
        ZStack {
            let basis = RoundedRectangle(cornerRadius: 12)
            if istDeutlichOeffentlich {
                basis.fill(.white)
                basis.strokeBorder(lineWidth: 3).foregroundColor(.red)
                Text(inhalt).font(.largeTitle)
            } else {
                basis.fill(.red) // Verdeckte Karte ist rot
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            istDeutlichOeffentlich.toggle() // Umschalten beim Antippen
        }
    }
}

#Preview {
    ContentView()
}
