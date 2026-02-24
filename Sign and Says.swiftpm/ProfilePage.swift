//
//  ProfilePage.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/24/26.
//

import SwiftUI

struct ProfilePage: View {
    @State var KidName: String = ""
    @State var Trigger: String = ""
    @State var Fixations: String = ""
    @State var Coping: String = ""
    
    var body: some View {
        ZStack {
            Color(.gray.opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Build Your Child's Profile")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 10)
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 75, weight: .bold))
                    .padding(.bottom, 5)
                Text("Add Profile Picture")
                    .font(.system(size: 20))
                    .padding(.bottom, 20)
                TextField("What's your child's name?", text:$KidName)
                Rectangle()
                    .frame( height: 1)
                    .foregroundColor(.gray).opacity(0.3)
                    .padding(.bottom, 20)
                
                TextField("What's your child's biggest trigger?", text:$Trigger)
                Rectangle()
                    .frame( height: 1)
                    .foregroundColor(.gray).opacity(0.3)
                    .padding(.bottom, 20)
                
                TextField("What are some of your child's fixations?", text: $Fixations)
                Rectangle()
                    .frame( height: 1)
                    .foregroundColor(.gray).opacity(0.3)
                    .padding(.bottom, 20)
                
                TextField("What's your child's favorite way to calm down?", text:$Coping)
                Rectangle()
                    .frame( height: 1)
                    .foregroundColor(.gray).opacity(0.3)
                    .padding(.bottom, 10)
                
                Text("Let's get to know \(KidName) better")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 20)
                
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ProfilePage()
}
