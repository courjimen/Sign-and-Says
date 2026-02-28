import SwiftUI

struct PECS: View {
    let icons: [Icon] = [Icon(name: "STOP", image: "StopSign"),
                         Icon(name: "BUBBLES", image: "Bubbles"),
                         Icon(name: "BATHROOM", image: "Bathroom"),
                         Icon(name: "Food", image: "Eat"),
                         Icon(name: "Books", image: "Books"),
                         Icon(name: "Sleep", image: "Bed")
    ]
    
    let words: [Word] = [Word(text: "I"),
                         Word(text: "want"),
                         Word(text: "please"),
                         Word(text: "go"),
                         Word(text: "my"),
                         Word(text: "to")
    ]
    
    var body: some View {
        ZStack {
            Color(Color("Grey").opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("My Helper Words:")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -15){
                        ForEach(words, id: \.self) { word in
                            WordCard(word: word)
                        }
                    }
                    .padding(.bottom, 5)
                }
                
                Text("My PECS Icons:")
                    .font(.headline)
                
                ScrollView(.horizontal) {
                    HStack(spacing: -15) {
                        ForEach(icons.prefix(icons.count/2), id: \.self) { icon in
                            IconCard(icon: icon)
                        }
                    }
                }
                .padding(-10)
                ScrollView(.horizontal) {
                    HStack(spacing: -15) {
                        ForEach(icons.suffix(from: icons.count/2), id: \.self) { icon in
                            IconCard(icon: icon)
                        }
                    }
                }
                .padding(-10)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PECS()
}
