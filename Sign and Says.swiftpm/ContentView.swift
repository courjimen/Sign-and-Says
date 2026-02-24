import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
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
                    CircleButton(title: "LEARN", color: Color(red: 244/255, green: 202/255, blue: 133/255))
                        .offset(x: 0, y: -70)
                    
                    // Notes (Left)
                    CircleButton(title: "NOTES", color: Color(red: 189/255, green: 224/255, blue: 254/255))
                        .offset(x: -80, y: 20)
                    
                    // Speak (Right)
                    CircleButton(title: "SPEAK", color: Color(red: 233/255, green: 237/255, blue:201/255))
                        .offset(x: 80, y: 20)
                    
                    // Sign (Bottom Left)
                    CircleButton(title: "SIGN", color: Color(red: 236/255, green: 215/255, blue: 247/255))
                        .offset(x: -60, y: 150)
                    
                    // Profile (Bottom Right)
                    CircleButton(title: "PROFILE", color: Color(red: 221/255, green: 184/255, blue: 146/255))
                        .offset(x: 60, y: 150)
                    
                }
                .padding(.bottom, 200)
                Spacer()
                HStack {
                    Image(systemName:"camera.circle.fill")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 50, weight: .bold))
                    //.padding(.trailing, 250)
                    Spacer()
                    
                    Image(systemName: "hand.rays.fill")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 50, weight: .bold))
                }
                .padding(.all, 40)
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
