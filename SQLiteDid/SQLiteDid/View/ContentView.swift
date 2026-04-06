import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var db = TodoDB()
    @State private var todos: [Todo] = []
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { item in
                    NavigationLink {
                        EditView(db: db, todo: item, onSave: loadData)
                    } label: {
                        HStack {
                            Button {
                                let result = db.updateCompleted(id: item.id, isCompleted: !item.isCompleted)
                                if result {
                                    loadData()
                                }
                            } label: {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .strikethrough(item.isCompleted)
                                    .foregroundColor(item.isCompleted ? .secondary : .primary)
                                
                                Text(priorityText(item.priority))
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: deleteTodo)
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddView = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                loadData()
            }
            .sheet(isPresented: $isShowingAddView, onDismiss: {
                loadData()
            }) {
                AddView(db: db, onSave: loadData)
            }
        }
    }
    
    func loadData() {
        todos = db.queryDB()
    }
    
    func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            _ = db.deleteDB(id: todo.id)
        }
        loadData()
    }
    
    func priorityText(_ priority: Int) -> String {
        switch priority {
        case 0: return "우선순위: 높음"
        case 1: return "우선순위: 중간"
        default: return "우선순위: 낮음"
        }
    }
}

#Preview {
    ContentView()
}
