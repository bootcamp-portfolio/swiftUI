import SwiftUI
import Combine

struct EditView: View {
    
    let db: TodoDB
    let todo: Todo
    let onSave: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var isCompleted: Bool
    @State private var priority: Int
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let priorities = ["높음", "중간", "낮음"]
    
    init(db: TodoDB, todo: Todo, onSave: @escaping () -> Void) {
        self.db = db
        self.todo = todo
        self.onSave = onSave
        
        _title = State(initialValue: todo.title)
        _isCompleted = State(initialValue: todo.isCompleted)
        _priority = State(initialValue: todo.priority)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Todo List")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("TodoList를 수정하거나 완료 상태를 변경 하세요")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    TextField("Todo", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 30)
                    
                    Toggle("할 일 완료", isOn: $isCompleted)
                        .padding(.horizontal, 30)
                    
                    Picker("우선순위", selection: $priority) {
                        ForEach(0..<priorities.count, id: \.self) { index in
                            Text(priorities[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 30)
                }
                
                HStack(spacing: 20) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                    
                    Button("수정") {
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "할 일을 입력하세요."
                            showAlert = true
                            return
                        }
                        
                        let result = db.updateDB(
                            id: todo.id,
                            title: title,
                            isCompleted: isCompleted,
                            priority: priority
                        )
                        
                        if result {
                            onSave()
                            dismiss()
                        } else {
                            alertMessage = "수정에 실패했습니다."
                            showAlert = true
                        }
                    }
                    .foregroundColor(.blue)
                    
                    Button("완료") {
                        let result = db.updateCompleted(id: todo.id, isCompleted: true)
                        if result {
                            onSave()
                            dismiss()
                        } else {
                            alertMessage = "완료 처리에 실패했습니다."
                            showAlert = true
                        }
                    }
                    .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .navigationTitle("수정 및 할일 완료")
            .navigationBarTitleDisplayMode(.inline)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("확인", role: .cancel) { }
            }
        }
    }
}
