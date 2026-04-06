import Foundation

struct Address: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var phone: String
    var address: String
    var relation: String
    var imageName: String?
}

