import SwiftUI

struct GetToKnowMePage: View {
    let KidName: String
    let Trigger: String
    let Fixations: String
    let Coping: String
    let results: [String: String]
    let profileImage: UIImage?

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack{Text("All About \(KidName)")
                        .font(.title2)
                        .fontWeight(.black)
                      
                    Spacer()
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 3)
                    }
                }
                
                    LazyVGrid(columns: columns, spacing: 12) {
                        CategoryTile(title: "Triggers", content: Trigger, color: Color(red: 0.95, green: 0.85, blue: 0.6))
                        CategoryTile(title: "Fixations", content: Fixations, color: Color(red: 0.75, green: 0.88, blue: 1.0))
                        CategoryTile(title: "Play", content: results["How does \(KidName) like to play?"] ?? "Not selected", color: Color(red: 0.9, green: 0.85, blue: 0.98))
                        CategoryTile(title: "Goals", content: results["What are your goals for \(KidName)?"] ?? "Not selected", color: Color(red: 0.92, green: 0.94, blue: 0.82))
                    }
                    
                    // --- NEW SECTIONS BELOW THE GRID ---
                    VStack(alignment: .leading, spacing: 5) {
                        DetailBanner(title: "Communication Style",
                                     content: results["What best summarizes \(KidName)'s communication style?"] ?? "Not selected",
                                     icon: "message.fill")
                        
                        DetailBanner(title: "Soothing Items",
                                     content: results["What are soothing items/things \(KidName) likes?"] ?? "Not selected",
                                     icon: "sparkles")
                        
                        DetailBanner(title: "Thrives In",
                                     content: results["What type of space does \(KidName) thrive in?"] ?? "Not selected",
                                     icon: "house.fill")
                        
                        DetailBanner(title: "Coping Strategy",
                                     content: Coping,
                                     icon: "heart.fill")
                    }
                   // .padding()
                }
                .padding(10)
                .background(Color(red: 0.98, green: 0.94, blue: 0.88))
                .cornerRadius(20)
                .padding(.horizontal)

                ShareLink(item: "Important Info for \(KidName)") {
                    Label("Share Profile", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("BabyBlue"))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
    }


// Reusable Banner for full-width details
struct DetailBanner: View {
    let title: String
    let content: String
    let icon: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.secondary)
                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}

// --- UPDATED CATEGORY TILE ---
struct CategoryTile: View {
    let title: String
    let content: String
    let color: Color

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            
            Text(content)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 125)
        .background(color)
        .cornerRadius(0)
    }
}
#Preview {
    GetToKnowMePage(
        KidName: "Courey",
        Trigger: "Loud noises and bright lights",
        Fixations: "Dinosaurs and trains",
        Coping: "Deep breathing and weighted blankets",
        results: [
            "What best summarizes Courey's communication style?": "PECS",
            "How does Courey like to play?": "Sensory"
        ],
        profileImage: nil
    )
}
