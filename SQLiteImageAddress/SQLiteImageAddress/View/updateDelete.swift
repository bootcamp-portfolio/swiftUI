import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var db: AddressDB
    let addressItem: Address
    let onSave: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var phone: String
    @State private var address: String
    @State private var relation: String
    @State private var selectedImage: UIImage
    
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    init(db: AddressDB, addressItem: Address, onSave: @escaping () -> Void) {
        self.db = db
        self.addressItem = addressItem
        self.onSave = onSave
        
        _name = State(initialValue: addressItem.name)
        _phone = State(initialValue: addressItem.phone)
        _address = State(initialValue: addressItem.address)
        _relation = State(initialValue: addressItem.relation)
        _selectedImage = State(initialValue: addressItem.image)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Form {
                    TextField("이름", text: $name)
                    TextField("전화번호", text: $phone)
                    TextField("주소", text: $address)
                    TextField("관계", text: $relation)
                }
                .frame(height: 220)
                
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                
                Button("Select an image") {
                    isShowingImagePicker = true
                }
                .foregroundColor(.gray)
                
                Button("수정") {
                    let result = db.updateDB(
                        id: addressItem.id,
                        name: name,
                        phone: phone,
                        address: address,
                        relation: relation,
                        image: selectedImage
                    )
                    
                    if result {
                        alertMessage = "수정 되었습니다."
                        showAlert = true
                    } else {
                        alertMessage = "수정 실패했습니다."
                        showAlert = true
                    }
                }
                .frame(width: 90, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
            }
            .navigationTitle("주소록 수정")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("확인") {
                    if alertMessage == "수정 되었습니다." {
                        onSave()
                        dismiss()
                    }
                }
            }
        }
    }
}
