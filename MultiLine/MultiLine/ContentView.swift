//
//  ContentView.swift
//  MultiLine
//
//  Created by electrozone on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isTextFieldFocused: Bool
    @State var inputText = ""//상태변수
    @State var enteredText = ""
    var body: some View {
        VStack {
 Text("TextField를 이용한 여러 Line 출력")
                .bold()
                .padding()//간격안이 넓어짐//마진 밖이 넓어짐
            //command+k:키보드
            HStack(content:
                    {TextField("문자입력",text:$inputText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)//크기})
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)//$
                    .focused($isTextFieldFocused)
            Button("추가",action: {
                let textCheck = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                if !textCheck.isEmpty{
                    enteredText += inputText + "\n"//누적
                }
                inputText=""
                isTextFieldFocused = false
            })
            })
            //textEditer 넓게 여러줄
            //TextEditor(text: .constant(enteredText))
            //scrollview씌우기 constant
            TextEditor(text:$enteredText)

                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)//크기
                .foregroundStyle(.black).bold()
                .colorMultiply(.gray.opacity(0.7))//투명도
                .clipShape(.rect(cornerRadius: 15))
            //.disabled(true)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

