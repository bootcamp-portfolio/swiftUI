import Foundation
import RealmSwift
import Combine

class AddressViewModel: ObservableObject {
    
    private var realm: Realm?
    @Published var items: [AddressItem] = []
    
    init() {
        openRealm()
        fetchItems()
    }
    
    func openRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Realm 열기 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchItems() {
        guard let realm = realm else { return }
        items = Array(realm.objects(AddressItem.self))
    }
    
    func addItem(
        name: String,
        phone: String,
        address: String,
        relation: String,
        imageName: String,
        imageData: Data?
    ) {
        guard let realm = realm else { return }
        
        let newItem = AddressItem()
        newItem.name = name
        newItem.phone = phone
        newItem.address = address
        newItem.relation = relation
        newItem.imageName = imageName
        newItem.imageData = imageData
        
        do {
            try realm.write {
                realm.add(newItem)
            }
            fetchItems()
        } catch {
            print("추가 실패: \(error.localizedDescription)")
        }
    }
    
    func updateItem(
        item: AddressItem,
        name: String,
        phone: String,
        address: String,
        relation: String,
        imageName: String,
        imageData: Data?
    ) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                item.name = name
                item.phone = phone
                item.address = address
                item.relation = relation
                item.imageName = imageName
                item.imageData = imageData
            }
            fetchItems()
        } catch {
            print("수정 실패: \(error.localizedDescription)")
        }
    }
    
    func deleteItem(item: AddressItem) {
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.delete(item)
            }
            fetchItems()
        } catch {
            print("삭제 실패: \(error.localizedDescription)")
        }
    }
}
