/* LEFT TO DO
 
 STRETCH GOALS
 Learn section will be a gamified version of signing
 Notes Section will be for goals/incident reporting from teacher, caregivers, etc
 Eventually include 3D hand model that uses AI to adjust to the sentence/command
 Incorporate visionOS to track hand movements and translate sign language
 */

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var showingAddSheet = false
    @State private var navigateToPecs =  false
    @State private var navigateToSign =  false
    
    @State private var icons: [Icon] = [Icon(name: "STOP", image: "StopSign"),
                                        Icon(name: "BUBBLES", image: "Bubbles"),
                                        Icon(name: "BATHROOM", image: "Bathroom"),
                                        Icon(name: "FOOD", image: "Eat"),
                                        Icon(name: "BOOKS", image: "Books"),
                                        Icon(name: "SLEEP", image: "Bed")
    ]
    
    @State private var words: [Word] = [Word(text: "I"),
                                        Word(text: "want"),
                                        Word(text: "please"),
                                        Word(text: "go"),
                                        Word(text: "my"),
                                        Word(text: "to")
    ]
    
    @State private var externalUiImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("Grey").opacity(0.3)).edgesIgnoringSafeArea(.all)
                NavigationLink(destination: PECS(icons: $icons, words: $words), isActive: $navigateToPecs) {
                    EmptyView()
                }
                VStack() {
                    // Header Section
                    VStack(spacing: 8) {
                        Text("Sign and Says")
                            .font(.system(size: 34, weight: .bold))
                        Text("Select your focus.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    // The Bubble Menu
                    ZStack {
                        // Learn (Top)
                        //CircleButton(title: "LEARN", color: Color("DustyOrange"))
                        //  .offset(x: 0, y: -70)
                        
                        // Notes (Left)
                        //CircleButton(title: "NOTES", color: Color("BabyBlue"))
                        //.offset(x: -80, y: 20)
                        
                        // Sign (Bottom Left)
                        VStack{
                            // Speak (Right)
                            NavigationLink(destination: PECS(icons: $icons, words: $words)) {
                                CircleButton(title: "SPEAK", color: Color("LightGreen"))
                            }
                            .padding()
                            NavigationLink(destination: Sign()){
                                CircleButton(title: "SIGN", color: Color("Lilac"))}
                            .padding()
                            
                            // Profile (Bottom Right)
                            NavigationLink(destination: ProfilePage()){
                                CircleButton(title: "PROFILE", color: Color("Cafe"))
                            }
                            .padding()
                        }
                    }
                    .padding()
                    Spacer()
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
                        .sheet(isPresented: $showingAddSheet, onDismiss: {
                            navigateToPecs = true
                        }) {
                            AddIconSheet(words: $words, icons: $icons)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "hand.rays.fill")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 50, weight: .bold))
                    }
                    .padding(.all, 40)
                }
            }
            
            .sheet(isPresented: $showingAddSheet) {
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
