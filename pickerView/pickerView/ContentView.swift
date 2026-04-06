//
//  ContentView.swift
//  pickerView
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let imageFileName = ["w1","w2","w3","w4","w5","w6","w7","w8","w9","w10"]
        @State var selectedImage = 0 //index
        VStack {
           Text("picker로 이미지 선택")
                .bold()
            Picker("", selection: $selectedImage, content: {
                ForEach(0..<imageFileName.count, id: \.self, content: {index in
                    //picker에 string
                    Image(imageFileName[index])
                        .resizable()
                        .frame(width: 50, height: 20)
                        .scaledToFit()
                    //Text("\(imageFileName[index]).jpg")
                })//foreach:dictionary(list) id
            })
            //.pickerStyle(.wheel)
            .pickerStyle(.palette)
            .padding()
            Text("Selected Item : \(imageFileName[selectedImage]).jpg")
            Image(imageFileName[selectedImage])
                .resizable()
                .frame(width: 350, height: 200)
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 15))
        }//함수 타이틀, 텍스트, 이미지 순서
        .padding()
    }
}

#Preview {
    ContentView()
}
