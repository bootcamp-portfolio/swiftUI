import SwiftUI

struct ContentView: View {
    
    // 화면에 쌓일 이모지
    @State private var emojis: [String] = []
    
    // 👉 애니메이션 상태 추가
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 120)
            
            // 🔥 이모지 표시 영역
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6),
                spacing: 12
            ) {
                ForEach(emojis.indices, id: \.self) { index in
                    Text(emojis[index])
                        .font(.system(size: 32))
                        // 👉 여기만 추가
                        .scaleEffect(
                            (index + 1) % 5 == 0
                            ? (isAnimating ? 1.5 : 1.0)
                            : 1.0
                        )
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // 🔥 버튼 3개
            HStack(spacing: 12) {
                
                Button {
                    emojis.append("😀")
                } label: {
                    buttonView("😀")
                }
                
                Button {
                    emojis.append("🥰")
                } label: {
                    buttonView("🥰")
                }
                
                Button {
                    emojis.append("🤓")
                } label: {
                    buttonView("🤓")
                }
            }
            .padding(.bottom, 40)
        }
        // 👉 애니메이션 실행
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
    
    func buttonView(_ emoji: String) -> some View {
        Text(emoji)
            .font(.system(size: 28))
            .frame(width: 64, height: 60)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 1.5)
            )
    }
}

#Preview {
    ContentView()
}
/*import SwiftUI

struct ContentView: View {
    
    // 화면에 쌓일 이모지
    @State private var emojis: [String] = []
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 120)
            
            // 🔥 이모지 표시 영역
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6),
                spacing: 12
            ) {
                ForEach(emojis.indices, id: \.self) { index in
                    Text(emojis[index])
                        .font(.system(size: 32))
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // 🔥 버튼 3개
            HStack(spacing: 12) {
                
                Button {
                    emojis.append("😀") // 누를 때마다 추가
                } label: {
                    buttonView("😀")
                }
                
                Button {
                    emojis.append("🥰")
                } label: {
                    buttonView("🥰")
                }
                
                Button {
                    emojis.append("🤓")
                } label: {
                    buttonView("🤓")
                }
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
    
    // 버튼 UI 재사용
    func buttonView(_ emoji: String) -> some View {
        Text(emoji)
            .font(.system(size: 28))
            .frame(width: 64, height: 60)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 1.5)
            )
    }
}

#Preview {
    ContentView()
}
*/
