//
//  WordCard.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/28/26.

import SwiftUI
struct WordCard: View {
    let word: Word
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 100)
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                .overlay(
                
                    Circle()
                        .stroke(Color("Lilac"), lineWidth: 5)
                )
            
            Text(word.text)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(.black)
                // Using your asset for the text's outer glow
                .shadow(color: Color("DustyOrange"), radius: 3, x: 1, y: 1)
                .shadow(color: Color("DustyOrange"), radius: 3, x: -1, y: -1)
                .multilineTextAlignment(.center)
                .frame(width: 100, height: 100)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .padding(5)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1).ignoresSafeArea()
        WordCard(word: Word(text: "Please"))
    }
}
