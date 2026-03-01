import SwiftUI
import PhotosUI

struct AddIconSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var words: [Word]
    @Binding var icons: [Icon]
    
    // NEW: Accepts an image if picked from the main screen
    var preSelectedImage: UIImage?
    
    @State private var mode = 0
    @State private var textInput = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var previewImage: UIImage?

    var body: some View {
        NavigationStack {
            Form {
                Picker("Category", selection: $mode) {
                    Text("Helper Word").tag(0)
                    Text("PECS Icon").tag(1)
                }
                .pickerStyle(.segmented)
                
                Section(header: Text("Details")) {
                    TextField(mode == 0 ? "Enter Word" : "Icon Label", text: $textInput)
                    
                    if mode == 1 {
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            HStack {
                                Label("Select Photo", systemImage: "photo.on.rectangle")
                                Spacer()
                                if let previewImage {
                                    Image(uiImage: previewImage)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .onChange(of: selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let ui = UIImage(data: data) {
                                    await MainActor.run { previewImage = ui }
                                }
                            }
                        }
                    }
                }
                
                Button("Save to Library") {
                    if mode == 0 {
                        words.append(Word(text: textInput))
                    } else {
                        icons.append(Icon(name: textInput, image: "photo", uiImage: previewImage))
                    }
                    dismiss()
                }
                .disabled(textInput.isEmpty || (mode == 1 && previewImage == nil))
            }
            .navigationTitle("Add to Board")
            .onAppear {
                // 4. If an image was passed in, set it as the preview and switch to Icon mode
                if let preSelectedImage {
                    self.previewImage = preSelectedImage
                    self.mode = 1
                }
            }
        }
    }
}

#Preview {
    AddIconSheet(
        words: .constant([Word(text: "I"), Word(text: "want")]),
        icons: .constant([Icon(name: "STOP", image: "StopSign")])
    )
}
