import SwiftUI

struct AddView: View {
    
    @Binding var todoLists: [TodoList]
    
    @State private var newItem: String = ""
    @State private var selectedImage: String = "clock"
    
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    let imageOptions: [String] = ["cart", "clock", "pencil"]
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer().frame(height: 20)
            
            HStack(spacing: 30) {
                ForEach(imageOptions, id: \.self) { image in
                    Button {
                        selectedImage = image
                    } label: {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundStyle(selectedImage == image ? .black : .gray)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedImage == image ? Color.gray.opacity(0.2) : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack {
                Text("항목 :")
                
                TextField("", text: $newItem)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .focused($isTextFieldFocused)
            }
            .padding(.horizontal)
            
            Button("Add") {
                guard !newItem.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                
                todoLists.append(
                    TodoList(items: newItem, itemsImageFile: selectedImage)
                )
                
                newItem = ""
                isTextFieldFocused = false
                dismiss()
            }
            
            Spacer()
        }
        .navigationTitle("Add View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isTextFieldFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        AddView(todoLists: .constant([]))
    }
}
