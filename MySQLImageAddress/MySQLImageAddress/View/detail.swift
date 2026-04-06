import SwiftUI

struct DetailView: View {
    @Binding var addressList: [Address]
    var selectedAddress: Address?
    var isNew: Bool
    
    // ✅ 작업 완료 후 실행할 클로저 (ContentView의 fetchAddresses를 실행함)
    var onComplete: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var relation: String = ""
    @State private var imageName: String = "dog"
    
    let imageOptions = ["dog", "cat", "fox"]
    let serverURL = "http://192.168.10.10:8001/addresses"
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        Form {
            Section(header: Text("기본 정보")) {
                TextField("이름", text: $name)
                TextField("전화번호", text: $phone)
                TextField("주소", text: $address)
                TextField("관계", text: $relation)
            }
            
            Section(header: Text("이미지 선택")) {
                HStack {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    Spacer()
                }
                HStack {
                    ForEach(imageOptions, id: \.self) { item in
                        Button(item) { imageName = item }
                            .buttonStyle(.bordered)
                            .tint(imageName == item ? .blue : .gray)
                    }
                }
            }
            
            Section {
                if isNew {
                    Button("등록") {
                        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           relation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "빈 칸 없이 입력해 주세요."
                            showAlert = true
                            return
                        }
                        let newItem = Address(name: name, phone: phone, address: address, relation: relation, imageName: imageName)
                        saveToServer(newItem, method: "POST", urlString: serverURL)
                    }
                    .frame(maxWidth: .infinity).foregroundColor(.blue)
                } else {
                    Button("수정") {
                        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           relation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "빈 칸 없이 입력해 주세요."
                            showAlert = true
                            return
                        }
                        if let id = selectedAddress?.id {
                            let updated = Address(id: id, name: name, phone: phone, address: address, relation: relation, imageName: imageName)
                            saveToServer(updated, method: "PUT", urlString: "\(serverURL)/\(id)")
                        }
                    }
                    .frame(maxWidth: .infinity).foregroundColor(.blue)
                    
                    Button("삭제") {
                        if let id = selectedAddress?.id {
                            deleteFromServer(id: id)
                        }
                    }
                    .frame(maxWidth: .infinity).foregroundColor(.red)
                }
            }
        }
        .onAppear {
            if let sa = selectedAddress {
                name = sa.name
                phone = sa.phone
                address = sa.address
                relation = sa.relation
                imageName = sa.imageName
            }
        }
        .alert("알림", isPresented: $showAlert) {
            Button("확인") {
                // 성공 메시지일 때만 onComplete + dismiss
                if alertMessage.contains("입력 되었습니다") ||
                   alertMessage.contains("수정 되었습니다") ||
                   alertMessage.contains("삭제 되었습니다") ||
                   alertMessage.contains("성공했습니다") {
                    onComplete()
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    // 서버 저장 및 수정 통신 함수
    func saveToServer(_ address: Address, method: String, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(address)
        } catch {
            DispatchQueue.main.async {
                alertMessage = "인코딩 오류: \(error.localizedDescription)"
                showAlert = true
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "네트워크 오류: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }
            guard let http = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    alertMessage = "응답 오류: HTTP 응답이 없습니다."
                    showAlert = true
                }
                return
            }
            let bodyText = String(data: data ?? Data(), encoding: .utf8) ?? ""
            if (200...299).contains(http.statusCode) {
                // 서버가 {"message": "..."} 형태로 응답
                var msg = "성공했습니다."
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let m = json["message"] as? String {
                    msg = m
                }
                DispatchQueue.main.async {
                    alertMessage = msg
                    showAlert = true
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "요청 실패(\(http.statusCode)): \(bodyText)"
                    showAlert = true
                }
            }
        }.resume()
    }

    // 서버 삭제 통신 함수
    func deleteFromServer(id: Int) {
        guard let url = URL(string: "\(serverURL)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "네트워크 오류: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }
            guard let http = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    alertMessage = "응답 오류: HTTP 응답이 없습니다."
                    showAlert = true
                }
                return
            }
            let bodyText = String(data: data ?? Data(), encoding: .utf8) ?? ""
            if (200...299).contains(http.statusCode) {
                var msg = "삭제 되었습니다."
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let m = json["message"] as? String {
                    msg = m
                }
                DispatchQueue.main.async {
                    alertMessage = msg
                    showAlert = true
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "요청 실패(\(http.statusCode)): \(bodyText)"
                    showAlert = true
                }
            }
        }.resume()
    }
}

