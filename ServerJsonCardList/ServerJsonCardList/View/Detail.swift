import SwiftUI

struct DetailView: View {
    
    let item: CardItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: item.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .clipped()
                        
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(item.category)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Written by \(item.writer)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("상세 내용 데이터는 현재 JSON에 없어서 제목, 작성자, 카테고리만 표시합니다.")
                    .font(.body)
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
    }
}
