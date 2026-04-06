import SwiftUI

struct EditView: View {
    @ObservedObject var vm: AddressViewModel
    @Environment(\.dismiss) var dismiss
    
    let item: AddressItem
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var relation: String = ""
    @State private var imageName: String = ""
    
    @State private var showUpdateAlert = false
    @State private var showDeleteAlert = false
    
    let imageList = ["cat", "dog", "bird", "defaultProfile"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("주소록 수정 및 삭제")
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
            
            Picker("이미지", selection: $imageName) {
                ForEach(imageList, id: \.self) { image in
                    Text(image).tag(image)
                }
            }
            .pickerStyle(.segmented)
            
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 120)
            
            Button("수정") {
                vm.updateItem(
                    item: item,
                    name: name,
                    phone: phone,
                    address: address,
                    relation: relation,
                    imageName: imageName, imageData: <#Data?#>
                )
                showUpdateAlert = true
            }
            .buttonStyle(.borderedProminent)
            
            Button("삭제") {
                vm.deleteItem(item: item)
                showDeleteAlert = true
            }
            .foregroundColor(.red)
            
            Spacer()
        }
        .padding()
        .onAppear {
            name = item.name
            phone = item.phone
            address = item.address
            relation = item.relation
            imageName = item.imageName
        }
        .alert("수정되었습니다.", isPresented: $showUpdateAlert) {
            Button("네, 알겠습니다.") {
                dismiss()
            }
        }
        .alert("삭제되었습니다.", isPresented: $showDeleteAlert) {
            Button("확인") {
                dismiss()
            }
        }
    }
}
