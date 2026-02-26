import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("Grey").opacity(0.5))
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
                        CircleButton(title: "SPEAK", color: Color("LightGreen"))
                            .offset(x: 80, y: 20)
                        
                        // Profile (Bottom Right)
                        NavigationLink(destination: ProfilePage()){
                            CircleButton(title: "PROFILE", color: Color("Cafe"))
                        }
                        .offset(x: 60, y: 150)
                    }
                    .padding(.bottom, 200)
                    Spacer()
                    HStack {
                        Image(systemName:"camera.circle.fill")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 50, weight: .bold))
                        //.padding(.trailing, 250)
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
