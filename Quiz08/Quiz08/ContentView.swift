import SwiftUI
import Combine

struct ContentView: View {
    // 로컬 asset 이미지 이름들 (Assets에 넣은 이름으로 바꿔주세요)
    private let images = ["flower_01", "flower_02", "flower_03"]

    @State private var index = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 12) {
            Text("3초마다 이미지 무한 반복")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)

            // 이미지: 가능한 크게 표시되도록 비율 유지하며 가로폭에 맞춤
            Image(images[index])
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            // 파일명 표시
            Text(images[index])
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom)
        }
        .padding(.horizontal)
        .onReceive(timer) { _ in
            index = (index + 1) % images.count
        }
    }
}

#Preview {
    ContentView()
}
