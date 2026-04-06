import SwiftUI

struct ContentView: View {
    
    @State var todoLists: [TodoList] = [
        TodoList(image: "bee", items: "벌", description: "이 동물의 이름은 벌이며 날수있습니다."),
        TodoList(image: "cat", items: "고양이", description: "이 동물의 이름은 고양이이며 포유류입니다."),
        TodoList(image: "cow", items: "젖소", description: "이 동물의 이름은 젖소이며 포유류입니다."),
        TodoList(image: "dog", items: "강아지", description: "이 동물의 이름은 강아지이며 귀여운 포유류입니다."),
        TodoList(image: "fox", items: "여우", description: "이 동물의 이름은 여우이며 포유류입니다."),
        TodoList(image: "monkey", items: "원숭이", description: "이 동물의 이름은 원숭이이며 포유류입니다."),
        TodoList(image: "pig", items: "돼지", description: "이 동물의 이름은 돼지이며 포유류입니다."),
        TodoList(image: "wolf", items: "늑대", description: "이 동물의 이름은 늑대이며 포유류입니다.")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoLists) { todo in
                    NavigationLink(destination: DetailView(todoList: todo)) {
                        BasicImageRow(todoList: todo)
                    }
                }
                .onDelete { indexSet in
                    deleteItem(at: indexSet)
                }
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        todoLists.remove(atOffsets: offsets)
    }
}

struct BasicImageRow: View {
    
    var todoList: TodoList
    
    var body: some View {
        HStack(spacing: 15) {
            Image(todoList.image)
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(todoList.items)
                .font(.system(size: 18))
        }
        .padding(.vertical, 5)
    }
}

struct DetailView: View {
    
    var todoList: TodoList
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(todoList.image)
                .resizable()
                .frame(width: 150, height: 150)
            
            Text(todoList.description)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
