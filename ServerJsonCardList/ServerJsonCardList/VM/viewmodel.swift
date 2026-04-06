import Foundation
internal import Combine

@MainActor
class CardListViewModel: ObservableObject {
    
    @Published var items: [CardItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchCards() async {
        guard let url = URL(string: "https://zeushahn.github.io/Test/ios/cards.json") else {
            errorMessage = "URL이 잘못되었습니다."
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                errorMessage = "서버 응답 오류: \(httpResponse.statusCode)"
                isLoading = false
                return
            }
            
            let decoded = try JSONDecoder().decode([CardItem].self, from: data)
            items = decoded
            
        } catch let decodingError as DecodingError {
            errorMessage = "JSON 해석 실패: \(decodingError.localizedDescription)"
        } catch {
            errorMessage = "데이터를 불러오지 못했습니다: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
