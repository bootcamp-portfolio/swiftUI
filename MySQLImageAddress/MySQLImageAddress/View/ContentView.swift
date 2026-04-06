import SwiftUI

struct ContentView: View {
    @State private var addressList: [Address] = []
    
    // ⚠️ 본인의 IP 주소로 수정 필수 (마지막에 점 . 이 없는지 확인!)
    let serverURL = "http://192.168.10.10:8001/addresses"

    var body: some View {
        NavigationStack {
            List {
                ForEach(addressList) { item in
                    NavigationLink {
                        // 수정/삭제 화면으로 이동 (클로저를 통해 새로고침 전달)
                        DetailView(addressList: $addressList, selectedAddress: item, isNew: false) {
                            fetchAddresses()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.phone).font(.subheadline).foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("주소록")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        // 새 등록 화면으로 이동 (클로저를 통해 새로고침 전달)
                        DetailView(addressList: $addressList, selectedAddress: nil, isNew: true) {
                            fetchAddresses()
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                fetchAddresses()
            }
        }
    }

    // 서버에서 전체 목록 불러오기 함수
    func fetchAddresses() {
        guard let url = URL(string: serverURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([Address].self, from: data)
                    DispatchQueue.main.async {
                        self.addressList = decoded
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}
