import SwiftUI

struct IconCard: View {
    let icon: Icon
    let isEditMode: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey"))
                .shadow(color: Color("DustyOrange"), radius: 10, x: 0, y: 5)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Group {
                        if let uiImage = icon.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Image(icon.image)
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        }
                    }
                        .scaledToFit()
                        .padding(10)
                )
            
            Text(icon.name.uppercased())
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        }
        .padding(12)
        .frame(width: 120, height: 160)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("LightGreen"))
        )
        
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1.5)
        )
        .padding()
        .onTapGesture {
            if !isEditMode {
                onTap()
            }
        }
    }
}

#Preview {
    IconCard(icon: Icon(name: "Stop", image: "StopSign"), isEditMode: true, onTap: {})
}
