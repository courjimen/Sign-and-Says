/* LEFT TO DO
 
 Attach logic to pass selected answers to final shareable page
 Allow users to save, download, or share the final page through text/bluetooth
 
 STRETCH GOAL
 Incorporate AI to analyze answers and create suggestions for parents/teachers
 */

import SwiftUI

struct Questionnaire: View {
    let KidName: String
    let Trigger: String
    let Fixations: String
    let Coping: String
    let profileImage: UIImage?
    
    @State private var currentIndex = 0
    @State private var selections: [String: String] = [:]
    @State private var showFinalPage = false
    
    var questions: [Question] {[
        Question(title: "What best summarizes \(KidName)'s communication style?",
                 options: ["PECS", "Gestures", "Vocals", "Drawings"]),
        Question(title: "What are soothing items/things \(KidName) likes?",
                 options: ["Brushing", "Visual Stimulation", "Physical Contact", "Quiet Space"]),
        Question(title: "How does \(KidName) like to play?",
                 options: ["Social", "Sensory", "Physical", "Constructive"]),
        Question(title: "What type of space does \(KidName) thrive in?",
                 options: ["Cozy Corners", "Quiet Space", "Toy Room", "Playground"]),
        Question(title: "What are your goals for \(KidName)?",
                 options: ["Initiating Requests", "Emotional Regulation", "Building Social Skills", "Turn Taking"])
    ]}
    
    
    var body: some View {
        ZStack {
            Color(Color("Cafe").opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                // Progress indicator (Optional but helpful)
                                Text("\(currentIndex + 1) / \(questions.count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                // Dynamic Title
                                Text(questions[currentIndex].title)
                                    .font(.system(size: 25, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .padding()
                
                            Text("Select the answer that best describes your child.")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 20)
                            
                            // Dynamic Buttons based on current question
                            VStack(spacing: 12) {
                                ForEach(questions[currentIndex].options, id: \.self) { option in
                                    MultipleChoiceButton(
                                        answer: option,
                                        isSelected: selections[questions[currentIndex].title] == option
                                    )
                                    .onTapGesture {
                                        selections[questions[currentIndex].title] = option
                                    }
                                }
                            }
                            .padding(.bottom, 50)
                            
                            // --- NAVIGATION LOGIC ---
                            
                            // 1. Next Question Button
                            if currentIndex < questions.count - 1 {
                                Button(action: { currentIndex += 1 }) {
                                    Rectangle()
                                        .frame(width: 175, height: 30)
                                        .foregroundColor(Color("BabyBlue"))
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                                        .overlay(Text("Next Question").foregroundStyle(.black))
                                }
                                .disabled(selections[questions[currentIndex].title] == nil)
                                .opacity(selections[questions[currentIndex].title] == nil ? 0.5 : 1.0)
                            }
                            
                            // 2. Previous Button
                            if currentIndex > 0 {
                                Button(action: { currentIndex -= 1 }) {
                                    Rectangle()
                                        .frame(width: 175, height: 30)
                                        .foregroundColor(Color("Cafe"))
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                                        .overlay(Text("Previous").foregroundStyle(.black))
                                }
                                .padding(.top, 10)
                            }
                            
                            // 3. Submit Button (Only shows on last question)
                            if currentIndex == questions.count - 1 {
                                NavigationLink(destination: GetToKnowMePage(KidName: KidName, Trigger: Trigger, Fixations: Fixations, Coping: Coping, results: selections, profileImage: profileImage)) {
                                    Rectangle()
                                        .frame(width: 175, height: 30)
                                        .foregroundColor(Color("LightGreen"))
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                                        .overlay(Text("Submit").foregroundStyle(.black))
                                }
                                .disabled(selections[questions[currentIndex].title] == nil)
                            }
                        }
                    }
                }
            }

            struct MultipleChoiceButton: View {
                let answer: String
                var isSelected: Bool = false
                
                var body: some View {
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 50) // Widened slightly for long text
                            .foregroundColor(isSelected ? Color("LightGreen") : Color("Grey").opacity(0.3))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                        
                        Text(answer)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
#Preview {
    Questionnaire(KidName: "", Trigger: "", Fixations: "", Coping: "", profileImage: nil)
}
