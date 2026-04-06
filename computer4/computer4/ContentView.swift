import SwiftUI

struct PhoneView: View {
    var title: String
    var product: String
    var size: String
    var weight: String
    var bag: String
    var color: String
    var isResult: Bool

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            if isResult {
                Text("제품: \(product)")
                Text("크기: \(size)")
                Text("무게: \(weight)")
                Text("가방여부: \(bag)")
                Text("색상: \(color)")
            } else {
                Text("입력 대기 상태")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .border(Color.black)
    }
}
