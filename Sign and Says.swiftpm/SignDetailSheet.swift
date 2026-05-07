import SwiftUI
import AVFoundation

struct SignDetailSheet: View {
    let aslSign: ASLSign
    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = verticalSizeClass == .compact
            let screenHeight = geometry.size.height
            let boxSize = isLandscape ? screenHeight * 0.6 : screenHeight * 0.55
            let imageSize = boxSize * 0.9
            
            VStack(spacing: isLandscape ? 8 : 15) {
                Text(aslSign.name.uppercased())
                    .font(.system(size: isLandscape ? 40 : 40, weight: .bold))
                    .foregroundColor(Color("Cafe"))
                    .minimumScaleFactor(0.5)
                    .padding(.top, isLandscape ? 10 : 30)
                    .padding(.leading, isLandscape ? 10: 30)
                
                // Image Container
                PhaseAnimator(aslSign.frames) { frameName in
                    Image(frameName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                        .id(frameName)
                } 
                .padding(.bottom)
                
                // Done Button
                Button(action: { dismiss() }) {
                    Text("DONE")
                        .font(.headline)
                        .frame(width: 160, height: 45)
                        .background(Color("LightGreen"))
                        .foregroundColor(.black)
                        .cornerRadius(25)
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                }
                .padding(.bottom, isLandscape ? 10 : 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        }
    }
    func speak(_ text: String) {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

#Preview (traits: .landscapeLeft){
    SignDetailSheet(
        aslSign: ASLSign(
            name: "Above",
            frames: ["above_1", "above_2", "above_3"],
            staticThumb: "above_1"
        )
    ) //.environment(\.colorScheme, .dark)
}
