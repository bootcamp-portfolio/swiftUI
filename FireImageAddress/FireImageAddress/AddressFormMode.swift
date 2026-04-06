//
//  AddressFormMode.swift
//  FireImageAddress
//
//  Created by electrozone on 4/1/26.
//


import SwiftUI

enum AddressFormMode {
    case add
    case edit(Address)
}

struct AddressFormView: View {
    @ObservedObject var vm: AddressBookViewModel
    let mode: AddressFormMode
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var id: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var relation: String = ""
    @State private var imageName: String = "dog"
    
    let imageOptions = ["dog", "cat", "fox"]
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("이름", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("전화번호", text: $phone)
                .textFieldStyle(.roundedBorder)
            
            TextField("주소", text: $address)
                .textFieldStyle(.roundedBorder)
            
            TextField("관계", text: $relation)
                .textFieldStyle(.roundedBorder)
            
            Text("이미지 선택")
                .foregroundColor(.gray)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
            
            HStack(spacing: 20) {
                ForEach(imageOptions, id: \.self) { item in
                    Button {
                        imageName = item
                    } label: {
                        Text(item)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(imageName == item ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(imageName == item ? .white : .black)
                            .cornerRadius(8)
                    }
                }
            }
            
            switch mode {
            case .add:
                Button("등록") {
                    vm.addAddress(
                        name: name,
                        phone: phone,
                        address: address,
                        relation: relation,
                        imageName: imageName
                    ) {
                        dismiss()
                    }
                }
                .padding()
                .frame(width: 120)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                
            case .edit:
                HStack(spacing: 20) {
                    Button("수정") {
                        vm.updateAddress(
                            id: id,
                            name: name,
                            phone: phone,
                            address: address,
                            relation: relation,
                            imageName: imageName
                        ) {
                            dismiss()
                        }
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .padding()
                    .frame(width: 100)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("삭제") {
                        vm.deleteAddress(id: id) {
                            dismiss()
                        }
                    }
                    .padding()
                    .frame(width: 100)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(titleText)
        .onAppear {
            setInitialData()
        }
    }
    
    var titleText: String {
        switch mode {
        case .add:
            return "주소록 등록"
        case .edit:
            return "주소록 수정/삭제"
        }
    }
    
    func setInitialData() {
        switch mode {
        case .add:
            break
        case .edit(let item):
            id = item.id
            name = item.name
            phone = item.phone
            address = item.address
            relation = item.relation
            imageName = item.imageName ?? "dog"
        }
    }
}
