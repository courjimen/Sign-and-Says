import SwiftUI
import PhotosUI

struct AddIconSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var words: [Word]
    @Binding var icons: [Icon]
    
    @State private var mode = 0 // 0 = Word, 1 = Icon
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
                // Optional: Clear image/text when switching modes
                .onChange(of: mode) { _, _ in
                    textInput = ""
                    previewImage = nil
                    selectedItem = nil
                }
                
                Section(header: Text("Details")) {
                    TextField(mode == 0 ? "Enter Word (e.g. 'More')" : "Icon Label (e.g. 'Apple')", text: $textInput)
                    
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
                        // FIXED: iOS 17 Syntax for onChange
                        .onChange(of: selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    // Ensure UI update happens on the main thread
                                    await MainActor.run {
                                        previewImage = uiImage
                                    }
                                }
                            }
                        }
                    }
                }
                
                Button("Save to Library") {
                    if mode == 0 {
                        words.append(Word(text: textInput))
                    } else {
                        // Ensure Icon model supports uiImage
                        icons.append(Icon(name: textInput, image: "photo", uiImage: previewImage))
                    }
                    dismiss()
                }
                // Disable button if validation fails
                .disabled(textInput.isEmpty || (mode == 1 && previewImage == nil))
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("Add to Board")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
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
