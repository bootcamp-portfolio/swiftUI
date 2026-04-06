import Foundation

struct Address: Identifiable, Codable {
    var id: Int?      // MySQL의 AUTO_INCREMENT 값
    var name: String
    var phone: String
    var address: String
    var relation: String
    var imageName: String
}
