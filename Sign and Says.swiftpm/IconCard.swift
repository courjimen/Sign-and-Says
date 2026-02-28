//
//  IconCard.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/22/26.
//
import SwiftUI

struct IconCardView: View {
    let icon: Icon
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey"))
                .shadow(color: Color("DustyOrange"), radius: 10, x: 0, y: 10)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(icon.image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                )
            
            Text(icon.name.uppercased())
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("LightGreen"))
        )
        
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.black, lineWidth: 1.5)
        )
        .frame(width: 250)
    }
}

#Preview {
    IconCardView(icon: Icon(name: "STOP", image: "StopSign"))
}
