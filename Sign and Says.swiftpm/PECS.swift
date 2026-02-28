/* LEFT TO DO
 Drag and drop words/icons
 Allow edit button to delete or add new words/icons
 - add logic for typable word icons to be created by user
 - add logic for images to be added by user and icon to be created
 Add voice to text for request bar
 Make search bar functional
 Create adjusted size for iPad/Tablet users
 
 STRETCH GOAL
 Add 3D hand model to sign the request bar sentence using AI (foundations)
 Allow categories for the PECS section and then a pop-up screen with additional icons
 */

import SwiftUI
import AVFoundation

struct PECS: View {
    @State private var searchText = ""
    @State private var requestText = ""
    @State private var isSpeaking = false
    
    let synthesizer = AVSpeechSynthesizer()
    
    let icons: [Icon] = [Icon(name: "STOP", image: "StopSign"),
                         Icon(name: "BUBBLES", image: "Bubbles"),
                         Icon(name: "BATHROOM", image: "Bathroom"),
                         Icon(name: "FOOD", image: "Eat"),
                         Icon(name: "BOOKS", image: "Books"),
                         Icon(name: "SLEEP", image: "Bed")
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
                        HStack{
                            ForEach(words, id: \.self) { word in
                                WordCard(word: word) {
                                    handleTap(text: word.text)
                                }
                                
                            }
                        }
                        .padding(.bottom, 5)
                    }
                    
                    Text("My PECS Icons:")
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: -15) {
                            ForEach(icons.prefix(icons.count/2), id: \.self) { icon in
                                IconCard(icon: icon) {
                                    handleTap(text: icon.name)
                                }
                            }
                        }
                    }
                    .padding(-10)
                    ScrollView(.horizontal) {
                        HStack(spacing: -15) {
                            ForEach(icons.suffix(from: icons.count/2), id: \.self) { icon in
                                IconCard(icon: icon) {
                                    handleTap(text: icon.name)
                                }
                            }
                        }
                    }
                    .padding(-10)
                    
                    //Request Strip
                    HStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSpeaking ? Color.yellow: Color("DustyOrange").opacity(0.5), lineWidth: isSpeaking ? 4 : 2)
                            .frame(height: 60)
                            .background(isSpeaking ? Color.yellow.opacity(0.2) : Color.white)
                            .cornerRadius(12)
                            .overlay(
                                HStack {
                                    Text(requestText.isEmpty ? "Tap icons to make request..." : requestText)
                                        .foregroundColor(requestText.isEmpty ? .gray : .black)
                                        .padding(.horizontal)
                                    
                                    Spacer()
                                    
                                    //Clear button
                                    if !requestText.isEmpty {
                                        Button(action: { requestText = ""}) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 22))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                }
                            )
                            .padding(.top, 10)
                            .animation(.easeInOut(duration: 0.2), value: isSpeaking)
                        Button(action: speakRequest) {
                            Image("Speak")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .padding(.bottom, 5)
                        .disabled(requestText.isEmpty)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    func speakRequest() {
        guard !requestText.isEmpty else { return }
        
        let utterance = AVSpeechUtterance(string: requestText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        // Visual feedback
        isSpeaking = true
        synthesizer.speak(utterance)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isSpeaking = false
        }
    }
    
    func handleTap(text: String) {
        if requestText.isEmpty {
            requestText = text
        } else {
            requestText += " \(text)"
        }
    }
}


#Preview {
    PECS()
}
