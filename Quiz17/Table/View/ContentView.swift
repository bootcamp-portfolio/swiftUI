//
//  ContentView.swift
//  Table
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    @State var todoLists: [TodoList] = [
        //<<<<<<<<<<<<<<<<< 연결
        TodoList(items: "책 구매", itemsImageFile: "cart"),
        TodoList(items: "철수와 약속", itemsImageFile: "clock"),
        TodoList(items: "스터디 준비하기", itemsImageFile: "pencil")
    ]
    //반복 그림 foreach
    var body: some View {
        NavigationView(content: {
            List(content: {
                ForEach(todoLists, content: {todo in//closure 변수//한세트
                    NavigationLink(destination: DetailView(todoLists: todo), label: {BasicImageRow(todoList: todo)
                        //
                    })
                })
            })
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    NavigationLink(destination: AddView(todoLists: $todoLists), label: {//<<<<<<<<<<<<<<<<<<<<<<
                        Image(systemName: "plus")//위치
                    })
                })
            })
        })//<<<<<<<<<<<<<<<<<<
        
    }
}//contentView

struct BasicImageRow: View {
    var todoList: TodoList//매개변수
    var body: some View {
    HStack(content: {
        Image(todoList.itemsImageFile)
            .resizable()
            .frame(width: 40, height: 40)
            .cornerRadius(5)
        Text(todoList.items)
    })
    }
}

#Preview {
    ContentView()
}
