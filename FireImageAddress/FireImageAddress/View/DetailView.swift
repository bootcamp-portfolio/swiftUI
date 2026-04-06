import SwiftUI

struct DetailView: View {
    let address: Address

    var body: some View {
        List {
            if let imageName = address.imageName, !imageName.isEmpty {
                Section("사진") {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets())
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }

            Section("기본 정보") {
                LabeledContent("이름", value: address.name)
                LabeledContent("관계", value: address.relation)
            }

            Section("연락처") {
                LabeledContent("전화번호", value: address.phone)
                LabeledContent("주소", value: address.address)
            }
        }
        .navigationTitle("상세 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        DetailView(address: Address(
            name: "홍길동",
            phone: "010-1234-5678",
            address: "서울특별시 중구 세종대로 110",
            relation: "친구",
            imageName: nil
        ))
    }
}
