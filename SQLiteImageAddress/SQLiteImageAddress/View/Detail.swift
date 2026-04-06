import SwiftUI

struct DetailView: View {
    
    @ObservedObject var db: AddressDB
    let addressItem: Address
    let onChange: () -> Void
    
    @State private var isShowingUpdateView = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Form {
                Section {
                    HStack {
                        Text("이름")
                        Spacer()
                        Text(addressItem.name)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("전화번호")
                        Spacer()
                        Text(addressItem.phone)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("주소")
                        Spacer()
                        Text(addressItem.address)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("관계")
                        Spacer()
                        Text(addressItem.relation)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 250)
            
            Image(uiImage: addressItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
            
            HStack(spacing: 20) {
                Button("수정") {
                    isShowingUpdateView = true
                }
                .frame(width: 80, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button("삭제") {
                    let result = db.deleteDB(id: addressItem.id)
                    if result {
                        onChange()
                        dismiss()
                    }
                }
                .frame(width: 80, height: 40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
        }
        .navigationTitle("주소록 상세")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingUpdateView, onDismiss: {
            onChange()
        }) {
            UpdateView(db: db, addressItem: addressItem, onSave: {
                onChange()
            })
        }
    }
}
