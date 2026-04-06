//
//  SecondView.swift
//  Navigation
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct SecondView: View {
//
//    @Binding var sharedData: String
//    @Binding var sharedLampStatus: String
    @EnvironmentObject var lampData: LampData
    @FocusState var isTextFieldFocused: Bool
    @State var toggleLabel = "On"
    @State var toggleStatus = true//<<
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                Text("Message")
                TextField("",text:$lampData.sharedData)//binding연결
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isTextFieldFocused)
            })
            
            HStack(content: {
                Spacer()
                Text(toggleLabel)
                Toggle("",isOn: $toggleStatus)
                    .labelsHidden()
                    .padding(.trailing,20)
                    .onChange(of: toggleStatus, {
                        if toggleStatus {
                            toggleLabel = "On"
                            lampData.sharedLampStatus = "lamp_on"
                        } else {
                            toggleLabel = "Off"
                            lampData.sharedLampStatus = "lamp_off"
                        }
                    })
            })
            
            
        })
        .navigationTitle("Second View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            toggleLabel = lampData.sharedLampStatus == "lamp_on" ? "On" : "Off"
            toggleStatus = lampData.sharedLampStatus == "lamp_on" ? true : false
        })
    }
}

#Preview {
    SecondView().environmentObject(LampData())
}//임시데이터//상태관리
//binding

