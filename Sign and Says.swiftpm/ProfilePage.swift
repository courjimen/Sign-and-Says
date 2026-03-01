import PhotosUI
import SwiftUI

struct ProfilePage: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var uiImage: UIImage?
    
    @State var KidName: String = ""
    @State var Trigger: String = ""
    @State var Fixations: String = ""
    @State var Coping: String = ""
    
    let detailLimit = 300
    let nameLimit = 50
    
    var body: some View {
        ZStack {
            Color(Color("Cafe").opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    Text("Build Your Child's Profile")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    // --- PHOTO PICKER ---
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
                        }
                    }
                    .padding(.bottom, 5)
                    .onChange(of: pickerItem) {
                        Task {
                            if let data = try? await pickerItem?.loadTransferable(type: Data.self),
                               let ui = UIImage(data: data) {
                                uiImage = ui
                                selectedImage = Image(uiImage: ui)
                            }
                        }
                    }
                    
                    Text("Add profile picture")
                        .padding(.bottom, 20)
                    
                    // --- INPUT FIELDS ---
                    VStack(spacing: 20) {
                        // Name Field
                        VStack(alignment: .leading) {
                            TextField("What's your child's name?", text: $KidName)
                                .onChange(of: KidName) { old, newValue in if newValue.count > nameLimit { KidName = String(newValue.prefix(nameLimit)) } }
                            underline
                        }
                        
                        // Trigger Field (Wrapping enabled via axis: .vertical)
                        VStack(alignment: .leading) {
                            TextField("What's your child's biggest trigger?", text: $Trigger, axis: .vertical)
                                .lineLimit(1...4)
                                .onChange(of: Trigger) { old, newValue in if newValue.count > detailLimit { Trigger = String(newValue.prefix(detailLimit)) } }
                            underline
                        }
                        
                        // Fixations Field
                        VStack(alignment: .leading) {
                            TextField("What are some of your child's fixations?", text: $Fixations, axis: .vertical)
                                .lineLimit(1...4)
                                .onChange(of: Fixations) { old, newValue in if newValue.count > detailLimit { Fixations = String(newValue.prefix(detailLimit)) } }
                            underline
                        }
                        
                        // Coping Field
                        VStack(alignment: .leading) {
                            TextField("How does your child calm down?", text: $Coping, axis: .vertical)
                                .lineLimit(1...4)
                                .onChange(of: Coping) { old, newValue in if newValue.count > detailLimit { Coping = String(newValue.prefix(detailLimit)) } }
                            underline
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Text("Let's get to know \(KidName) better")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 20)
                    
                    // --- NAVIGATION ---
                    NavigationLink(destination: Questionnaire(KidName: KidName, Trigger: Trigger, Fixations: Fixations, Coping: Coping, profileImage: uiImage)) {
                        Rectangle()
                            .frame(width: 175, height: 35)
                            .foregroundColor(Color("BabyBlue"))
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                            .overlay(Text("Take Questionnaire").foregroundStyle(.black).bold())
                    }
                    //.padding()
                }
            }
        }
    }
    
    // Helper view for the bottom line
    var underline: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray).opacity(0.3)
    }
}
                
#Preview {
    ProfilePage(KidName: "Courey")
}
