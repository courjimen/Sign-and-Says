import SwiftUI
import AVFoundation

struct Sign: View {
    @State private var selectedSign: ASLSign? = nil
    private let synthesizer = AVSpeechSynthesizer()
    
    let aslSigns: [ASLSign] = [
        ASLSign(name: "Above", frames: ["above_1", "above_2", "above_3"], staticThumb: "above_1"),
        ASLSign(name: "Eat", frames: ["eat_1", "eat_2", "eat_3"], staticThumb: "eat_1"),
        ASLSign(name: "Brother", frames: ["bro_1", "bro_2", "bro_3"], staticThumb: "bro_1"),
        ASLSign(name: "Drink", frames: ["drink_1", "drink_2", "drink_3"], staticThumb: "drink_1"),
        ASLSign(name: "I Don't Know", frames: ["dunno_1", "dunno_2", "dunno_3"], staticThumb: "dunno_1"),
        ASLSign(name: "Help", frames: ["help_1", "help_2", "help_3"], staticThumb: "help_1"),
        ASLSign(name: "iPhone", frames: ["iPhone_1", "iPhone_2", "iPhone_3"], staticThumb: "iPhone_1"),
        ASLSign(name: "I Love You", frames: ["loveu_1", "loveu_2", "loveu_3"], staticThumb: "loveu_1"),
        ASLSign(name: "Mommy", frames: ["mom_1", "mom_2", "mom_3"], staticThumb: "mom_1"),
        ASLSign(name: "More", frames: ["more_1", "more_2", "more_3"], staticThumb: "more_1")
    ]
    
    var body: some View {
        ZStack{
            Color(Color("LightGreen").opacity(0.3)).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Practice ASL")
                    .font(.title2)
                    .foregroundColor(.secondary)
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
