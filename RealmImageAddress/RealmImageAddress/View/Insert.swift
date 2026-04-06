import SwiftUI
import PhotosUI

struct AddView: View {
    @ObservedObject var vm: AddressViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var relation = ""
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("주소록 입력")
                .font(.title3)
            
            TextField("이름", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("전화번호", text: $phone)
                .textFieldStyle(.roundedBorder)
            
            TextField("주소", text: $address)
                .textFieldStyle(.roundedBorder)
            
            TextField("관계", text: $relation)
                .textFieldStyle(.roundedBorder)
            
            Text("Select an image")
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let data = selectedImageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            
            Button("등록") {
                vm.addItem(
                    name: name,
                    phone: phone,
                    address: address,
                    relation: relation,
                    imageName: "",
                    imageData: selectedImageData
                )
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .alert("입력되었습니다.", isPresented: $showAlert) {
            Button("네, 알겠습니다.") {
                dismiss()
            }
        }
    }
}
