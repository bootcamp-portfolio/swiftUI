import SwiftUI

struct ContentView: View {
    
    let images: [String] = [
        "flower_01",
        "flower_02",
        "flower_03",
        "flower_04",
        "flower_05",
        "flower_06"
    ]
    
    @State private var currentIndex: Int = 0
    
    // 다음 이미지 번호 계산
    var nextIndex: Int {
        if currentIndex < images.count - 1 {
            return currentIndex + 1
        } else {
            return currentIndex
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer().frame(height: 20)
            
            Text("\(images[currentIndex]).png")
                .font(.title3)
                .fontWeight(.bold)
            
            // 큰 이미지 + 오른쪽 위 다음 이미지 미리보기
            ZStack(alignment: .topTrailing) {
                
                // 현재 큰 이미지
                Image(images[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 320, height: 500)
                    .clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                
                // 다음 이미지 미리보기
                if currentIndex < images.count - 1 {
                    Image(images[nextIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 70)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.red, lineWidth: 2)
                        )
                        .padding(.top, 6)
                        .padding(.trailing, 6)
                }
            }
            .frame(width: 220, height: 300)
            
            Spacer()
            
            HStack {
                Button("👈") {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }
                .font(.system(size: 24))
                .frame(maxWidth: .infinity)
                
                Button("👉") {
                    if currentIndex < images.count - 1 {
                        currentIndex += 1
                    }
                }
                .font(.system(size: 24))
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 80)
            .padding(.bottom, 30)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
