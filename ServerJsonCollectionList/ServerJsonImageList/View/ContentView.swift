import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var movies: [MovieJSON] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(movies, id: \.title) { movie in
                        NavigationLink(destination: DetailView(movie: movie)) {
                            WebImage(url: URL(string: movie.image))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 140)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let queryModel = QueryModel()
                
                Task {
                    do {
                        movies = try await queryModel.loadData(
                            url: URL(string: "https://zeushahn.github.io/Test/ios/movies.json")!
                        )
                    } catch {
                        print("데이터 로드 실패: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
