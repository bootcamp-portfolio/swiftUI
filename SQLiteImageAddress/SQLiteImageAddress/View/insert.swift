import SwiftUI

struct AddView: View {
    
    @ObservedObject var db: AddressDB
    let onSave: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var relation = ""
    
    @State private var selectedImage = UIImage(systemName: "photo")!
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                
                Button("등록") {
                    if name.isEmpty || phone.isEmpty || address.isEmpty || relation.isEmpty {
                        alertMessage = "모든 항목을 입력하세요."
                        showAlert = true
                        return
                    }
                    
                    let result = db.insertDB(
                        name: name,
                        phone: phone,
                        address: address,
                        relation: relation,
                        image: selectedImage
                    )
                    
                    if result {
                        alertMessage = "입력 되었습니다."
                        showAlert = true
                    } else {
                        alertMessage = "입력 실패했습니다."
                        showAlert = true
                    }
                }
                .frame(width: 90, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
            }
            .navigationTitle("주소록 입력")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("확인") {
                    if alertMessage == "입력 되었습니다." {
                        onSave()
                        dismiss()
                    }
                }
            }
        }
    }
}
