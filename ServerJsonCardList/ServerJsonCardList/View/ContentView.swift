import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CardListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("불러오는 중...")
                } else if !viewModel.errorMessage.isEmpty {
                    VStack(spacing: 12) {
                        Text("오류 발생")
                            .font(.headline)
                        
                        Text(viewModel.errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button("다시 불러오기") {
                            Task {
                                await viewModel.fetchCards()
                            }
                        }
                        .padding(.top, 8)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.items) { item in
                                NavigationLink {
                                    DetailView(item: item)
                                } label: {
                                    CardRowView(item: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("News")
            .task {
                await viewModel.fetchCards()
            }
        }
    }
}

#Preview {
    ContentView()
}
