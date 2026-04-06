//
//  AddView.swift
//  CollectionViewHV_Label
//

import SwiftUI

struct AddView: View {
    
    @Binding var dataArray: [String]
    @State private var newName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("인물 이름 입력", text: $newName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("추가") {
                if !newName.trimmingCharacters(in: .whitespaces).isEmpty {
                    dataArray.append(newName)
                    newName = ""
                }
            }
            .frame(width: 120, height: 45)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationTitle("인물 추가")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddView(dataArray: .constant(["유비", "관우"]))
}
