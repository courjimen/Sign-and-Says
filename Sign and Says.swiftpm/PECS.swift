/* LEFT TO DO
 Allow categories for the PECS section and then a pop-up screen with additional icons
 - Food: Burger, Pizza, Cookies
 - Drinks: Water, Juice, Milk, Tea, Slushie
 - Play: Park, Tag, Beach, Movies, Blocks, Toys, Friends
 -Family: Mom, Dad, siblings
 
 Allow AI to assess what the user use the most and keep those words/icons pinned
 Create adjustable size for iPad/Tablet users
 Add options for spanish/bilingual
 
 STRETCH GOAL
 Add 3D hand model to sign the request bar sentence using AI (foundations)
 */

import SwiftUI
import AVFoundation
import PhotosUI

struct PECS: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var searchText = ""
    @State private var requestText = ""
    @State private var isSpeaking = false
    @State private var showEmptyAlert = false
    @State private var isEditMode = false
    @State private var showingAddSheet = false
    
    @Binding var icons: [Icon]
    @Binding var words: [Word]
    
    let synthesizer = AVSpeechSynthesizer()
    
    
    var filteredWords: [Word] {
        searchText.isEmpty ? words : words.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
    }
    var filteredIcons: [Icon] {
        searchText.isEmpty ? icons : icons.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        ZStack {
            Color(Color("Grey").opacity(0.1))
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 0) {
                    // Edit & Search Bar
                    HStack(spacing: 15) {
                        Button(isEditMode ? "Done" : "Edit") {
                            withAnimation(.spring()) {
                                isEditMode.toggle()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(isEditMode ? Color.blue : Color.white)
                        .foregroundColor(isEditMode ? .white : .gray)
                        .clipShape(Capsule())
                        
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
                        HStack {
                            Text("Helper Words")
                                .font(.headline)
                            if isEditMode {
                                Button(action: { showingAddSheet = true }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title2)
                                }
                            }
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(filteredWords) { word in
                                    ZStack(alignment: .topTrailing) {
                                        WordCard(word: word, isEditMode: isEditMode) {
                                            handleTap(text: word.text)
                                        }
                                        if isEditMode {
                                            DeleteButton { words.removeAll(where: { $0.id == word.id }) }
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 15)
                        }
                        
                        //Icon Section
                        HStack {
                            Text("PECS Icons")
                                .font(.headline)
                            if isEditMode {
                                Button(action: { showingAddSheet = true }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title2)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        let midIndex = filteredIcons.count / 2
                        let topRow = filteredIcons.prefix(midIndex)
                        let bottomRow = filteredIcons.suffix(from: midIndex)
                        
                        VStack(spacing: -10) {
                            //Top Row
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: -15) {
                                    ForEach(topRow) { icon in
                                        ZStack(alignment: .topTrailing) {
                                            IconCard(icon: icon, isEditMode: isEditMode) {
                                                handleTap(text: icon.name)
                                            }
                                            if isEditMode {
                                                DeleteButton { icons.removeAll(where: { $0.id == icon.id }) }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Bottom Row
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: -15) {
                                    ForEach(bottomRow) { icon in
                                        ZStack(alignment: .topTrailing) {
                                            IconCard(icon: icon, isEditMode: isEditMode) {
                                                handleTap(text: icon.name)
                                            }
                                            if isEditMode {
                                                DeleteButton { icons.removeAll(where: { $0.id == icon.id }) }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.horizontal, -20)
                        
                        //Request Strip
                        HStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSpeaking ? Color.yellow: Color("DustyOrange").opacity(0.5), lineWidth: isSpeaking ? 4 : 2)
                                .frame(height: 60)
                                .background(isSpeaking ? Color.yellow.opacity(0.2) : Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    HStack {
                                        Text(requestText.isEmpty ? "Tap icons or words..." : requestText)
                                            .foregroundColor(requestText.isEmpty ? .gray : .black)
                                            .padding(.horizontal)
                                        Spacer()
                                        if !requestText.isEmpty {
                                            Button(action: { requestText = "" }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.gray)
                                                    .font(.system(size: 22))
                                            }
                                            .padding(.trailing, 10)
                                        }
                                    }
                                )
                            
                            Button(action: speakRequest) {
                                Image("Speak")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical)
        }
        
        .sheet(isPresented: $showingAddSheet) {
            AddIconSheet(words: $words, icons: $icons)
        }
        .alert("Empty Request", isPresented: $showEmptyAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please tap an icon to make a request.")
        }
    }
    @ViewBuilder
    func DeleteButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.red)
                .background(Color.white.clipShape(Circle()))
                .font(.title2)
        }
        .offset(x: -10, y: 3)
    }
    
    @ViewBuilder
    func AddCircleButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.green)
                Text("ADD").font(.caption).bold().foregroundColor(.green)
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 2)
        }
    }
    
    func speakRequest() {
        if requestText.isEmpty { showEmptyAlert = true; return }
        let utterance = AVSpeechUtterance(string: requestText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        isSpeaking = true
        synthesizer.speak(utterance)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isSpeaking = false
            requestText = ""
            
        }
    }
    func handleTap(text: String) {
        requestText += requestText.isEmpty ? text : " \(text)"
    }
}

#Preview (traits: .landscapeLeft){
    PECS(
        icons: .constant([Icon(name: "stop", image: "StopSign"),
                          Icon(name: "bubbles", image: "Bubbles"),
                          Icon(name: "bathroom", image: "Bathroom"),
                          Icon(name: "food", image: "Eat"),
                          Icon(name: "books", image: "Books"),
                          Icon(name: "sleep", image: "Bed")
                         ]),
        words: .constant([Word(text: "I"),
                          Word(text: "want"),
                          Word(text: "please"),
                          Word(text: "go"),
                          Word(text: "my"),
                          Word(text: "to")
        ])
    )
}
