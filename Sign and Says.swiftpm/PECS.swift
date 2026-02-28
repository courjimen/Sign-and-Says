import SwiftUI

struct PECS: View {
    let icons: [Icon] = [Icon(name: "STOP", image: "StopSign"),
                         Icon(name: "BUBBLES", image: "Bubbles"),
                         Icon(name: "BATHROOM", image: "Bathroom")
    ]
    
    let words: [Word] = [Word(text: "I"),
                         Word(text: "want"),
                         Word(text: "please"),
                         Word(text: "go")
    ]

    
    var body: some View {
        ZStack {
            Color(Color("Grey").opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(words, id: \.self) { word in
                            WordCard(word: word)
                        }
                    }
                }
                Text("PECS Page")
            }
        }
    }
}

#Preview {
    PECS()
}
