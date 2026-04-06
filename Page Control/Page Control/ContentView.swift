import SwiftUI

struct ContentView: View {
    
    let flowers: [String] = [
        "flower_01",
        "flower_02",
        "flower_03",
        "flower_04",
        "flower_05",
        "flower_06"
    ]
    
    @State private var currentPage: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                
                Spacer().frame(height: 20)
                
                // 현재 이미지 이름
                Text(flowers[currentPage])
                    .font(.headline)
                    .fontWeight(.semibold)
                
                // 페이지 스와이프 영역
                TabView(selection: $currentPage) {
                    ForEach(0..<flowers.count, id: \.self) { index in
                        Image(flowers[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 260, height: 340)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .tag(index)
                    }
                }
                .frame(width: 300, height: 380)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear {
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor(red: 0.7, green: 1.0, blue: 0.4, alpha: 1.0) // 연두색 기본 점
                    UIPageControl.appearance().currentPageIndicatorTintColor = .red // 선택된 점 빨간색
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
