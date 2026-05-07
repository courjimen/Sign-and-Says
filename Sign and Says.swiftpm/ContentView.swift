/* LEFT TO DO
 
 STRETCH GOALS
 Learn section will be a gamified version of signing
 Notes Section will be for goals/incident reporting from teacher, caregivers, etc
 Eventually include 3D hand model that uses AI to adjust to the sentence/command
 Incorporate visionOS to track hand movements and translate sign language
 
 Finalized button menu with all 5 options:
 
 The Bubble Menu
 ZStack {
 // Learn (Top)
 CircleButton(title: "LEARN", color: Color("DustyOrange"))
 .offset(x: 0, y: 0)
 
 //Notes (Left)
 CircleButton(title: "NOTES", color: Color("BabyBlue"))
 .offset(x: -90, y: 100)
 
 // Regular Navigation Link for the Button
 NavigationLink(destination: PECS(icons: $icons, words: $words)) {
 CircleButton(title: "SPEAK", color: Color("LightGreen"))
 }
 .buttonStyle(PlainButtonStyle())
 .offset(x: 90, y: 100)
 
 NavigationLink(destination: Sign()) {
 CircleButton(title: "SIGN", color: Color("Lilac"))
 }
 .buttonStyle(PlainButtonStyle())
 .offset(x: -70, y: 230)
 
 
 NavigationLink(destination: ProfilePage()) {
 CircleButton(title: "PROFILE", color: Color("Cafe"))
 }
 .buttonStyle(PlainButtonStyle())
 .offset(x: 70, y: 230)
 
 .padding()
 }
 Spacer()
 */

import SwiftUI
import PhotosUI

struct ContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var showingAddSheet = false
    @State private var navigateToPecs = false
    
    // Load data
    @State private var icons: [Icon] = PersistenceManager.loadIcons()
    @State private var words: [Word] = PersistenceManager.loadWords()
    @State private var externalUiImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("Grey").opacity(0.3)).edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Header Section
                    VStack() {
                        Text("Sign & Says")
                            .font(.system(size: 34, weight: .bold))
                            .padding(.top)
                        Text("Select your focus.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    // The Bubble Menu
                    Group {
                        if verticalSizeClass == .regular {
                            VStack {
                                NavigationLink(destination: PECS(icons: $icons, words: $words)) {
                                    CircleButton(title: "SPEAK", color: Color("LightGreen"))
                                }
                                NavigationLink(destination: Sign()) {
                                    CircleButton(title: "SIGN", color: Color("Lilac"))
                                }
                                
                                NavigationLink(destination: ProfilePage()) {
                                    CircleButton(title: "PROFILE", color: Color("Cafe"))
                                }
                            }
                            .padding()
                        } else {
                            // LANDSCAPE VIEW
                            HStack(spacing: 40) {
                                NavigationLink(destination: PECS(icons: $icons, words: $words)) {
                                    CircleButton(title: "SPEAK", color: Color("LightGreen"))
                                }
                                
                                NavigationLink(destination: Sign()) {
                                    CircleButton(title: "SIGN", color: Color("Lilac"))
                                }
                                
                                NavigationLink(destination: ProfilePage()) {
                                    CircleButton(title: "PROFILE", color: Color("Cafe"))
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    
                    Spacer()
                    
                    // Footer Buttons
                    HStack {
                        Button(action: { showingAddSheet = true }) {
                            ZStack {
                                Circle()
                                    .fill(Color("BabyBlue"))
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 2)
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: Onboarding(hasCompletedOnboarding: .constant(false))) {
                            Image(systemName: "questionmark.circle")
                                .foregroundStyle(.primary)
                                .font(.system(size: 50, weight: .bold))
                        }
                    }
                    .padding(.all, 40)
                }
            }
            .navigationDestination(isPresented: $navigateToPecs) {
                PECS(icons: $icons, words: $words)
            }
            // 1. Load data if UserDefaults was updated elsewhere
            .onAppear {
                let savedIcons = PersistenceManager.loadIcons()
                let savedWords = PersistenceManager.loadWords()
                if !savedIcons.isEmpty { self.icons = savedIcons }
                if !savedWords.isEmpty { self.words = savedWords }
            }
            // 2. Save data whenever the arrays change
            .onChange(of: icons) { oldValue, newValue in
                PersistenceManager.savePECS(icons: newValue, words: words)
            }
            .onChange(of: words) { oldValue, newValue in
                PersistenceManager.savePECS(icons: icons, words: newValue)
            }
            // 3. SINGLE Add Sheet (Combined)
            .sheet(isPresented: $showingAddSheet, onDismiss: {
                //Takes user straight to PECS if they add something from the menu
                withAnimation { navigateToPecs = true }
            }) {
                AddIconSheet(words: $words, icons: $icons, preSelectedImage: externalUiImage)
            }
        }
    }
}

struct CircleButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(color)
                .frame(width: 125, height: 125)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ContentView()
 //.environment(\.colorScheme, .dark)
}

