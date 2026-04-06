import Foundation

struct CardItem: Codable, Hashable, Identifiable {
    let title: String
    let image: String
    let category: String
    let writer: String
    
    var id: String { image + title }
    
    enum CodingKeys: String, CodingKey {
        case title = "heading"
        case image
        case category
        case writer = "author"
    }
}
