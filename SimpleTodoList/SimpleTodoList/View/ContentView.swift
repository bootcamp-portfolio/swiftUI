//
//  ContentView.swift
//  SimpleTodoList
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI
//appbar button navigation
struct ContentView: View {
    @State var todoLists: [TodoList] = [
        TodoList(items: "꽃 선물 준비")
    ]
    @State var isSheet: Bool = false
    @State var userInput: String = ""
    
    var body: some View {
    NavigationView(content: {
        List(content: {
            ForEach(todoLists, content: {
                todo in
                BasicImageRow(todoList: todo)
            })
            .onDelete(perform: {
                indexSet in deleteItem(at: indexSet)//함수
            })
        })
        .navigationTitle("Main View")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content:{
            ToolbarItem(placement: .topBarTrailing, content: {
            Image(systemName: "plus")
                    .onTapGesture(perform: {
                        isSheet.toggle()
                    })
                    .sheet(isPresented: $isSheet, content: {
                        VStack(content: {
                            Text("추가할 내용을 입력 하세요.")
                                .bold()
                                .padding()
                            TextField("추가할 내용 입력", text: $userInput)
                                .padding()
                                .textFieldStyle(.roundedBorder)
                            Button("OK", action: {
                                isSheet.toggle()
                                if userInput != ""{
                                    todoLists.append(TodoList(items: userInput))
                                
                                }
                                userInput = ""
                            })

                        })
                    })
                    })
        })
    })
    }
    //function
    func deleteItem(at offsets: IndexSet){
        todoLists.remove(atOffsets: offsets)
    }
}//contentView
struct BasicImageRow: View {
    var todoList: TodoList
    var body: some View{
        HStack(content: {
            Image(systemName: "house.circle")
                .font(.system(size: 50))
            Text(todoList.items)
        })
    }
}

#Preview {
    ContentView()
}
