/* Create categories:
 Family
 Actions
 Food
 Requests
 
 ADD NOW
 
 wait
 hungry
 good morning/night
 tired
 happy
 sad
 */
import SwiftUI
import AVFoundation

struct Sign: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss // Standard way to handle back button
    
    @State private var searchSign = ""
    @State private var selectedSign: ASLSign? = nil
    private let synthesizer = AVSpeechSynthesizer()
    
    let aslSigns: [ASLSign] = [
        ASLSign(name: "Daddy", frames: ["Daddy 1", "Daddy 2", "Daddy 3"], staticThumb: "Daddy 1"),
        ASLSign(name: "Sister", frames: ["sister 1", "sister 2", "sister 3"], staticThumb: "sister 1"),
        ASLSign(name: "Grandpa", frames: ["gramps 1", "gramps 2", "gramps 3"], staticThumb: "gramps 1"),
        ASLSign(name: "Cousin", frames: ["cousin 1", "cousin 2", "cousin 3"], staticThumb: "cousin 1"),
        ASLSign(name: "Grandma", frames: ["grammy 1", "grammy 2", "grammy 3"], staticThumb: "grammy 1"),
        ASLSign(name: "Mommy", frames: ["mom_1", "mom_2", "mom_3"], staticThumb: "mom_1"),
        ASLSign(name: "Brother", frames: ["bro_1", "bro_2", "bro_3"], staticThumb: "bro_1"),
        ASLSign(name: "Drink", frames: ["drink_1", "drink_2", "drink_3"], staticThumb: "drink_1"),
        ASLSign(name: "Wait", frames: ["wait 1", "wait 2", "wait 3"], staticThumb: "wait 1"),
        ASLSign(name: "Sorry", frames: ["sorry 1", "sorry 2", "sorry 3"], staticThumb: "sorry 1"),
        ASLSign(name: "iPhone", frames: ["iPhone_1", "iPhone_2", "iPhone_3"], staticThumb: "iPhone_1"),
        ASLSign(name: "I Don't Know", frames: ["dunno_1", "dunno_2", "dunno_3"], staticThumb: "dunno_1"),
        ASLSign(name: "Help", frames: ["help_1", "help_2", "help_3"], staticThumb: "help_1"),
        ASLSign(name: "I Love You", frames: ["loveu_1", "loveu_2", "loveu_3"], staticThumb: "loveu_1"),
        ASLSign(name: "Above", frames: ["above_1", "above_2", "above_3"], staticThumb: "above_1"),
        ASLSign(name: "Eat", frames: ["eat_1", "eat_2", "eat_3"], staticThumb: "eat_1"),
        ASLSign(name: "More", frames: ["more_1", "more_2", "more_3"], staticThumb: "more_1"),
        ASLSign(name: "Thank You", frames: ["thank u 1", "thank u 2", "thank u 3"], staticThumb: "thank u 1"),
        ASLSign(name: "Stop", frames: ["Stop 1", "Stop 2", "Stop 3"], staticThumb: "Stop 1"),
        ASLSign(name: "Please", frames: ["please 1", "please 2", "please 3"], staticThumb: "please 1")
    ]
    
    var filteredSign: [ASLSign] {
        searchSign.isEmpty ? aslSigns : aslSigns.filter { $0.name.localizedCaseInsensitiveContains(searchSign) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("LightGreen").opacity(0.3)).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        // Dynamic Grid sizing
                        let minWidth: CGFloat = verticalSizeClass == .regular ? 175 : 150
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth))], spacing: 15) {
                            ForEach(filteredSign) { sign in
                                SignCard(aslSign: sign) {
                                    playSignSound(name: sign.name)
                                    selectedSign = sign
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: 20)
                        
                        //TITLE
                        Text("Practice ASL")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.secondary)
                            .fixedSize()
                        
                        Spacer()
                            .frame(width: 20)
                        
                        //SEARCH BAR
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchSign)
                                .textInputAutocapitalization(.never)
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.trailing, 12)
                    .frame(width: UIScreen.main.bounds.width - (verticalSizeClass == .regular ? 60 : 140))
                }
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

#Preview  {
    Sign()
    //  .environment(\.colorScheme, .dark)
}
