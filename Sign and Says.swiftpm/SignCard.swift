//
//  SignCard.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/28/26.
//
import SwiftUI

struct SignCard: View {
    let aslSign: ASLSign
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Cafe"))
                .shadow(color: Color("LightGreen"), radius: 10, x: 0, y: 5)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(aslSign.staticThumb)
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                )
            
            Text(aslSign.name.uppercased())
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 8)
        }
        .padding(10)
        .frame(width: 175, height: 200)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color("Lilac")))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1.5))
        .onTapGesture { onTap() }
    }
}

#Preview {
    SignCard(
        aslSign: ASLSign(
            name: "Above",
            frames: ["above_1", "above_2", "above_3"],
            staticThumb: "above_1"
        ),
        onTap: {
            print("Sign Card Tapped!")
        }
    )
    
    .preferredColorScheme(.light) 
}
