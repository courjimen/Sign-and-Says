//
//  ProfilePage.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 2/24/26.
//
import PhotosUI
import SwiftUI

struct ProfilePage: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State var KidName: String = ""
    @State var Trigger: String = ""
    @State var Fixations: String = ""
    @State var Coping: String = ""
    
    var body: some View {
        ZStack {
            Color(Color("Grey").opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Build Your Child's Profile")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 10)
                
                //Gallery Access
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125, height: 125)
                            .font(.system(size: 75, weight: .bold))
                            .padding(.bottom, 5)
                    }
                }
                .onChange(of: pickerItem) {
                    Task {
                        if let image = try? await pickerItem?.loadTransferable(type: Image.self) {
                            selectedImage = image                        }
                    }
                }
                
                Text("Add profile picture")
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
                
                NavigationLink (destination: Questionnaire()){
                    Rectangle()
                        .frame(width: 175, height: 30)
                        .foregroundColor(Color("BabyBlue"))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                        .overlay(Text("Take Questionnaire").foregroundStyle(.black))
                }
                
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ProfilePage()
}
