//
//  DetailView.swift
//  Table
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct DetailView: View {
    var todoLists: TodoList
    
    var body: some View {
        VStack(content: {
            Image(todoLists.itemsImageFile)
                .resizable()
                .frame(width: 100, height: 100)
                .fixedSize()
                .padding(.bottom, 10)
                .scaledToFit()
            
            Text(todoLists.items)
                
        })
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(todoLists: TodoList(items: "aaa", itemsImageFile: "cart"))
}
