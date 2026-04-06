import SwiftUI
import Combine

struct AddView: View {
    
    let db: TodoDB
    let onSave: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var priority = 1
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let priorities = ["높음", "중간", "낮음"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Todo List")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("추가할 내용을 입력 해주세요")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextField("Meet Cathy", text: $title)
                        .textFieldStyle(.roundedBorder)
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
                    
                    Button("추가") {
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "할 일을 입력하세요."
                            showAlert = true
                            return
                        }
                        
                        let result = db.insertDB(title: title, isCompleted: false, priority: priority)
                        
                        if result {
                            onSave()
                            dismiss()
                        } else {
                            alertMessage = "저장에 실패했습니다."
                            showAlert = true
                        }
                    }
                    .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .navigationTitle("입력")
            .navigationBarTitleDisplayMode(.inline)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("확인", role: .cancel) { }
            }
        }
    }
}
