import Foundation

struct Todo: Identifiable, Hashable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var priority: Int
}
