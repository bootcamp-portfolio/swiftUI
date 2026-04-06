//
//  main.swift
//  computer
//
//  Created by electrozone on 3/26/26.
//

import SwiftUI
//state중요 달러 표시
struct ContentView: View {
    @State var productName=""//property
    @State var screenSize=""
    @State var weight=""//string
    @State var bag=""//string
    @State var color=""//string
    var body: some View {
        VStack(spacing:10,content:{
            Text("Computer 사양")
                .bold()
                .padding(50)
            HStack(
                spacing:10,content:{
                    Text("제품명:")
                        .frame(minWidth: 80, alignment: .leading)
                    TextField("제품명을 입력하세요",text:$productName)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                }
            )
            HStack(
                spacing:10,content:{
                    Text("화면크기:")
                        .frame(minWidth: 80, alignment: .leading)
                    TextField("화면크기을 입력하세요",text:$screenSize)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                }
            )
            HStack(
                spacing:10,content:{
                    Text("무게:")
                        .frame(minWidth: 80, alignment: .leading)
                    TextField("무게을 입력하세요",text:$weight)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                }
            )
            HStack(
                spacing:10,content:{
                    Text("가방:")
                        .frame(minWidth: 80, alignment: .leading)
                    TextField("가방을 입력하세요",text:$bag)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                }
            )
            HStack(
                spacing:10,content:{
                    Text("색상:")//크기
                        .frame(minWidth: 80, alignment: .leading)
                    TextField("색상을 입력하세요",text:$color)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:200)
                }
            )
            Button("OK",action:{
                let productName_T:String = "맥북프로"
                let screenSize_T:Int = 14
                let weight_T:Double = 1.63
                let bag_T:Bool = false
                let color_T :Character="백"
                
                productName=productName_T
                screenSize=String(screenSize_T)
                weight=String(weight_T)
                bag=String(bag_T)
                color=String(color_T)//변환 String
            })
            .padding()
            .frame(width:80)
//            .backgroud(.blue)
//            .foregroundStyle(.white)
//            .clipShape(.buttonBorder)
            
            Button("Clear",action:{
                productName.removeAll()
                screenSize.removeAll()
                weight.removeAll()
                bag.removeAll()
                color.removeAll()
                
            })
            .padding()
            .frame(width:80)
            .foregroundStyle(.red)
            .border(.red,width:1)
       Spacer()
        })
        .padding()//safearea:vstack 감싸줌
    }
}
//
//@main
//struct ComputerApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

#Preview {
    ContentView()
}
