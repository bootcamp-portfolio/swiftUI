import Foundation

struct TodoList: Identifiable {
    var id = UUID()
    var image: String
    var items: String
    var description: String
}
