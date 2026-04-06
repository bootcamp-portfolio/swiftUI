import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let movie: MovieJSON
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(movie.title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            WebImage(url: URL(string: movie.image))
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 300)
                .cornerRadius(10)
            
            Spacer()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(
        movie: MovieJSON(
            image: "https://via.placeholder.com/300x450",
            title: "테스트 영화"
        )
    )
}
