//
//  Sign.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/28/26.
//

import SwiftUI
import AVFoundation

struct Sign: View {
    @State private var selectedSign: ASLSign? = nil
    private let synthesizer = AVSpeechSynthesizer()
    
    let aslSigns: [ASLSign] = [
        ASLSign(name: "Above", frames: ["above_1", "above_2", "above_3"], staticThumb: "above_1"),
        ASLSign(name: "Eat", frames: ["eat_1", "eat_2", "eat_3"], staticThumb: "eat_1")
    ]
    
    var body: some View {
        ZStack{
            Color(Color("LightGreen").opacity(0.3)).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                    ForEach(aslSigns) { sign in
                        SignCard(aslSign: sign) {
                            playSignSound(name: sign.name)
                            selectedSign = sign
                        }
                    }
                }
                .padding()
            }
            .sheet(item: $selectedSign) { sign in
                SignDetailSheet(aslSign: sign)
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    func playSignSound(name: String) {
        let utterance = AVSpeechUtterance(string: name)
        utterance.rate = 0.4
        self.synthesizer.speak(utterance)
    }
}
#Preview {
    Sign()
}
