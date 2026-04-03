import Foundation
import SwiftUI

struct Icon: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var image: String 
    var imageData: Data?
    var uiImage: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
}

struct Word: Identifiable, Hashable, Codable {
    var id = UUID()
    let text: String
}

struct Question: Identifiable {
    let id = UUID()
    let title: String
    let options: [String]
}

struct ASLSign: Identifiable {
    let id = UUID()
    let name: String
    let frames: [String]
    let staticThumb: String
}
