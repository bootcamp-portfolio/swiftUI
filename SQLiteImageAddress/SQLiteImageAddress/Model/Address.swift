import SwiftUI

struct Address: Identifiable, Hashable {
    var id: Int   // DB에서 가져오는 PK
    var name: String
    var phone: String
    var address: String
    var relation: String
    var image: UIImage
    
    // 생성자
    init(id: Int, name: String, phone: String, address: String, relation: String, image: UIImage) {
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
        self.relation = relation
        self.image = image
    }
}
