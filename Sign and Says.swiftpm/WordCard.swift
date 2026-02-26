//
//  WordCard.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/22/26.
//

import SwiftUI

struct WordCard: View {
    let word: Word
    
    var body: some View {
        Text("Word Card")
    }
}

struct Word: Hashable {
    let text: String
}

#Preview {
    WordCard(word: Word(text: "Hello"))
}
