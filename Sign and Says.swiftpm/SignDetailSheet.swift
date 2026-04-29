import SwiftUI
import AVFoundation

struct SignDetailSheet: View {
    let aslSign: ASLSign
    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        Group {
            if verticalSizeClass == . regular {
                VStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 6)
                        .padding(.top, 10)
                    
                    Text(aslSign.name.uppercased())
                        .font(.system(size: 40, weight: .black))
                        .padding(.top, 20)
                        .foregroundColor(Color("Cafe"))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("Grey").opacity(0.1))
                            .frame(width: 300, height: 300)
                        
                        PhaseAnimator(aslSign.frames) { frameName in
                            Image(frameName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                                .id(frameName)
                        } animation: { _ in
                                .easeInOut(duration: 0.7)
                        }
                    }
                    
                    Button(action: { dismiss() }) {
                        Text("DONE")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color("LightGreen"))
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .onAppear {
                    speak(aslSign.name)
                }
            } else {
                VStack (spacing: -2){
                    Text(aslSign.name.uppercased())
                        .font(.system(size: 40, weight: .black))
                        .foregroundColor(Color("Cafe"))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("Grey").opacity(0.1))
                            .frame(width: 300, height: 300)
                        
                        PhaseAnimator(aslSign.frames) { frameName in
                            Image(frameName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                                .id(frameName)
                        } animation: { _ in
                                .easeInOut(duration: 0.7)
                        }
                    }
                    
                    Button(action: { dismiss() }) {
                        Text("DONE")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color("LightGreen"))
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .onAppear {
                    speak(aslSign.name)
                }
            }
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
