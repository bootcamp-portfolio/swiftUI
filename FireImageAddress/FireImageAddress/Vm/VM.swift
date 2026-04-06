import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class AddressBookViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let collectionName = "addresses"
    
    @Published var items: [Address] = []
    
    func fetchAddresses() {
        db.collection(collectionName).addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("[Firestore] fetch error: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            let mapped: [Address] = documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                guard let name = data["name"] as? String,
                      let phone = data["phone"] as? String,
                      let address = data["address"] as? String,
                      let relation = data["relation"] as? String else {
                    return nil
                }
                let imageName = data["imageName"] as? String
                return Address(id: id, name: name, phone: phone, address: address, relation: relation, imageName: imageName)
            }
            DispatchQueue.main.async {
                self.items = mapped
            }
        }
    }
    
    func addAddress(name: String, phone: String, address: String, relation: String, imageName: String, completion: @escaping () -> Void) {
        let data: [String: Any] = [
            "name": name,
            "phone": phone,
            "address": address,
            "relation": relation,
            "imageName": imageName
        ]
        db.collection(collectionName).addDocument(data: data) { error in
            if let error = error {
                print("[Firestore] add error: \(error)")
            }
            completion()
        }
    }
    
    func updateAddress(id: String, name: String, phone: String, address: String, relation: String, imageName: String, completion: @escaping () -> Void) {
        let data: [String: Any] = [
            "name": name,
            "phone": phone,
            "address": address,
            "relation": relation,
            "imageName": imageName
        ]
        db.collection(collectionName).document(id).setData(data, merge: true) { error in
            if let error = error {
                print("[Firestore] update error: \(error)")
            }
            completion()
        }
    }
    
    func deleteAddress(id: String, completion: @escaping () -> Void) {
        db.collection(collectionName).document(id).delete { error in
            if let error = error {
                print("[Firestore] delete error: \(error)")
            }
            completion()
        }
    }
}

