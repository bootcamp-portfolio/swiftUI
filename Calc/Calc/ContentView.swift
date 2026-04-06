//
//  ContentView.swift
//  Calc
//
//  Created by electrozone on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isTextFieldFocused: Bool
    @State var firstNum = ""
    @State var secondNum = ""
    @State var result = ""
    
    var body: some View {
        VStack {
            
            Text("클래스를 통한 덧셈 계산")
                .bold()
            .padding(.bottom,80)
            VStack {
                Color.gray.ignoresSafeArea(edges: .all)
                HStack{
                    Text("첫번째 숫자")
                    TextField("0",text:$firstNum)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:100)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .focused(($isTextFieldFocused))
                    
                }
            }
            HStack{
                Text("두번째 숫자")
                TextField("0",text:$secondNum)
                    .textFieldStyle(.roundedBorder)
                    .frame(width:100)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused(($isTextFieldFocused))
                
            }
            Button("Add",action:{
                //입력을 안하였을 경우 기본값 0으로 대체
                //iflet/guardlet대신
                let num1 = Int(firstNum) ?? 0
                let num2 = Int(secondNum) ?? 0
                
               //result = "\(num1 + num2)"
                let addition = Addition()
                result = String(addition.add(num1, num2))
                //result = "\(addition.result)"
                isTextFieldFocused = false
            })
            .frame(width: 120, height: 40)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            .padding()
            ZStack(content: {//이미지 위에 이미지
                Color.gray.ignoresSafeArea(edges: .all)//제일밑//위에 아이콘? 제외한 부분
                Text(result)
                    .bold()
            })
            .frame(width: 300, height: 50)//stack별로 컬러 가능
        }//zstack 위로 쌓기
        .padding()
    }
}

#Preview {
    ContentView()
}
