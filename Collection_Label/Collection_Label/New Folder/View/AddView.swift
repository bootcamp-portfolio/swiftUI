//
//  AddView.swift
//  Collection_Label
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI

struct AddView: View {
    @Binding var dataArray: [String] // dataArray
    @FocusState private var isTextFieldFocused: Bool
    @State private var nameItem: String = ""
    @Environment(\.dismiss) private var dismiss // 버튼 누르면 넘어감
    
    var body: some View {
        VStack {
            Text("인물")
            TextField("", text: $nameItem)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
                .multilineTextAlignment(.leading)
                .keyboardType(.default)
                .focused($isTextFieldFocused)
            
            Button("추가") {
                dataArray.append(nameItem)
                nameItem = ""
                isTextFieldFocused = false
                dismiss()
            }
            .padding(.top, 12)
        }
        .padding()
        .navigationTitle(Text("추가"))
    }
}

#Preview {
    AddView(dataArray: .constant([]))
}
