//
//  IconCard.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/22/26.

import SwiftUI

struct IconCard: View {
    let icon: Icon
    let isEditMode: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey"))
                .shadow(color: Color("DustyOrange"), radius: 10, x: 0, y: 10)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Group {
                    if let uiImage = icon.uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
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
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        }
        .padding(15)
        .frame(width: 125)
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
       // .frame(width: 125)
    }
}

#Preview {
    IconCard(icon: Icon(name: "Stop", image: "StopSign"), isEditMode: true, onTap: {})
}
