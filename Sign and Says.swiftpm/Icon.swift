import Foundation
import SwiftUI

struct Icon:  Identifiable, Hashable {
    let id = UUID()
    var name: String
    var image: String
    var uiImage: UIImage?
}

struct Word: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

struct Question: Identifiable {
    let id = UUID()
    let title: String
    let options: [String]
}
