/* LEFT TO DO
 Finalize Menu (maybe decrease to 3 options: Profile, Sign & Speak)
 Sign section includes videos/imagery icons to sign commands
 Add remaining assets/icons for built in options
 Fix logic to go to new popup screen to add icon from gallery.
 
 STRETCH GOALS
 Learn section will be a gamified version of signing
 Eventually include 3D hand model that uses AI to adjust to the sentence/command
 Incorporate visionOS to track hand movements and translate sign language
 */

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("Grey").opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    // Header Section
                    VStack(spacing: 8) {
                        Text("Sign and Says")
                            .font(.system(size: 34, weight: .bold))
                        Text("Select your focus.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // The Bubble Menu
                    ZStack { 
                        // Learn (Top)
                        CircleButton(title: "LEARN", color: Color("DustyOrange"))
                          .offset(x: 0, y: -70)
                        
                        // Notes (Left)
                        CircleButton(title: "NOTES", color: Color("BabyBlue"))
                            .offset(x: -80, y: 20)
                        
                        // Sign (Bottom Left)
                        CircleButton(title: "SIGN", color: Color("Lilac"))
                            .offset(x: -60, y: 150)
                        
                        // Speak (Right)
                        NavigationLink(destination: PECS()){
                            CircleButton(title: "SPEAK", color: Color("LightGreen"))
                        }  .offset(x: 80, y: 20)
                        
                        // Profile (Bottom Right)
                        NavigationLink(destination: ProfilePage()){
                            CircleButton(title: "PROFILE", color: Color("Cafe"))
                        }
                        .offset(x: 60, y: 150)
                    }
                    .padding(.bottom, 200)
                    Spacer()
                    HStack {
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            if let selectedImage {
                                selectedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                            } else {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .onChange(of: pickerItem) {
                            Task {
                                if let image = try? await pickerItem?.loadTransferable(type: Image.self) {
                                    selectedImage = image                        }
                            }
                        }
                        Spacer()
                        
                        Image(systemName: "hand.rays.fill")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 50, weight: .bold))
                    }
                    .padding(.all, 40)
                }
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
                .frame(width: 100, height: 100)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}
