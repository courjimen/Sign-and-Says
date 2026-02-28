import SwiftUI

struct PECS: View {
    @State private var searchText = ""
    @State private var requestText = ""
    
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
            Color(Color("Grey").opacity(0.1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // --- TOP BAR ---
                HStack(spacing: 15) {
                    Button("Edit") {
                        // Action for edit mode
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(white: 0.8))
                    .foregroundColor(.gray)
                    .clipShape(Capsule())
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                    }
                    .padding(8)
                    .background(Color(white: 0.9))
                    .cornerRadius(10)
                
                }
                .padding()
                
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
                    
                    //Request Strip
                    HStack{
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("DustyOrange").opacity(0.5), lineWidth: 2)
                            .frame(height: 60)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                Text(requestText.isEmpty ? "Drag icons to say request..." : requestText)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                , alignment: .leading
                            )
                            .padding()
                        Image(systemName: "speaker.fill") // Settings icon
                            .font(.title2)
                        
                    }
                    
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    PECS()
}
