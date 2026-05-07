import Foundation

class PersistenceManager {
    static let iconKey = "saved_icons"
    static let wordKey = "saved_words"

    // MARK: - Save
    static func savePECS(icons: [Icon], words: [Word]) {
        let encoder = JSONEncoder()
        if let encodedIcons = try? encoder.encode(icons) {
            UserDefaults.standard.set(encodedIcons, forKey: iconKey)
        }
        if let encodedWords = try? encoder.encode(words) {
            UserDefaults.standard.set(encodedWords, forKey: wordKey)
        }
    }

    static func loadIcons() -> [Icon] {
        guard let data = UserDefaults.standard.data(forKey: iconKey),
              let decoded = try? JSONDecoder().decode([Icon].self, from: data) else {
            // Return default icons if none are saved yet
            return [
                Icon(name: "stop", image: "StopSign"),
                Icon(name: "bubbles", image: "Bubbles"),
                Icon(name: "bathroom", image: "Bathroom"),
                Icon(name: "food", image: "Eat"),
                Icon(name: "books", image: "Books"),
                Icon(name: "sleep", image: "Bed"),
                Icon(name: "toys", image: "toys"),
                Icon(name: "ice cream", image: "helado"),
                Icon(name: "outside", image: "park"),
                Icon(name: "swing", image: "swing"),
                Icon(name: "blocks", image: "blocks"),
                Icon(name: "slide", image: "slide")
            ]
        }
        return decoded
    }

    static func loadWords() -> [Word] {
        guard let data = UserDefaults.standard.data(forKey: wordKey),
              let decoded = try? JSONDecoder().decode([Word].self, from: data) else {
            // Return default words if none are saved yet
            return [
                Word(text: "I"),
                Word(text: "want"),
                Word(text: "please"),
                Word(text: "go"),
                Word(text: "my"),
                Word(text: "to")
            ]
        }
        return decoded
    }
}
