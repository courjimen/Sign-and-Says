//
//  Questionnaire.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/25/26.

//Need 4 questions and to pass the different answers/score each selection also need to pass child's name from profile page.

/* QUESTIONS
 COMMUNICATION
 What best summarizes your child's communication style?
 - PECS
 - Gestures
 - Vocals
 -Drawings
 
 SENSORY
 What are soothing items/things your child likes?
 Brushing
 Visual Stimulation (i.e. ASMR videos, colors)
 Physical Contact (i.e. hugs)
 Quiet Space

 PLAY
 How does your child like to play?
 Social (i.e. interactive games with others)
 Sensory (i.e. play-doh, kinetic sand, water)
 Physical (i.e. tag, climbing)
 Constructive (i.e. legos, puzzles)

 ENVIRONMENT
 What type of space does your child thrive in?
 Cozy Corners
 Quiet Space
 Toy Room
 Playground

 GOALS
 What are your goals for your child?
 Initiating Requests
 Emotional Regulation
 Building Social Skills
 Turn Taking
 */

import SwiftUI

struct Questionnaire: View {
    @State var KidName: String = ""
    
    var body: some View {
            ZStack {
                Color(Color("Cafe").opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    Text("What best summarizes your child's communication style?")
                        .font(.system(size: 25, weight: .bold))
                        .padding()
                    Text("Select the answer that best describes your child.")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                    
                    MultipleChoiceButton(answer: "PECS")
                    MultipleChoiceButton(answer: "Gestures")
                    MultipleChoiceButton(answer: "Vocals")
                    MultipleChoiceButton(answer: "Drawings")
                        .padding(.bottom, 50)
                    
                    Rectangle()
                        .frame(width: 175, height: 30)
                        .foregroundColor(Color("BabyBlue"))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                        .overlay(Text("Next Question").foregroundStyle(.black))
                    Rectangle()
                        .frame(width: 175, height: 30)
                        .foregroundColor(Color("Cafe"))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                        .overlay(Text("Previous").foregroundStyle(.black))
                    
                    Rectangle()
                        .frame(width: 175, height: 30)
                        .foregroundColor(Color("LightGreen"))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
                        .overlay(Text("Submit").foregroundStyle(.black))
                }
        }
    }
}

//struct Questions: Identifiable, Equatable {
//   let id = UUID()
//    let question: String
//    let answer1: String
//    let answer2: String
//    let answer3: String
//    let answer4: String
//}

struct MultipleChoiceButton: View {
    let answer: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 175, height: 50)
                .foregroundColor(Color("Grey").opacity(0.3))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            
            Text(answer)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}
#Preview {
    Questionnaire()
}
