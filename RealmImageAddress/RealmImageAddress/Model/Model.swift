import Foundation
import RealmSwift

class AddressItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var phone: String = ""
    @Persisted var address: String = ""
    @Persisted var relation: String = ""
    @Persisted var imageName: String = ""
    @Persisted var imageData: Data?
}
