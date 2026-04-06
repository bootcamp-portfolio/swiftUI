//
//  ContentView.swift
//  Navigation
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    @State var sharedData: String = ""
    @State var sharedLampStatus = "lamp_on"
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
       NavigationStack {
           VStack(content: {
               //<<<<<<<<<<<<<<<<<<<
               Image(sharedLampStatus)
                   .resizable()
                   .frame(width: 180, height: 300)
                   .fixedSize()
                   .padding(.bottom,10)
                   .scaledToFit()//순서 중요

               HStack(content: {
                   Text("Message")
                   TextField("",text: $sharedData)
                       .textFieldStyle(.roundedBorder)
                       .frame(width: 200)
                       .multilineTextAlignment(.leading)
                       .keyboardType(.default)
                       .focused($isTextFieldFocused)
                   
                   NavigationLink(destination: SecondView(sharedData: $sharedData, sharedLampStatus: $sharedLampStatus), label: {
                       Text("수정")//binding 생성자
                   })
               })
               .padding()
           })
           .navigationTitle(Text("Main Title"))
           .navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

#Preview {
    ContentView()
}
