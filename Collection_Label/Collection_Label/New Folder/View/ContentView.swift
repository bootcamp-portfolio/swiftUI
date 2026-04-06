//
//  ContentView.swift
//  Collection_Label
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI

struct ContentView: View {
    @State var dataArray: [String] = ["유비", "관우", "장비", "조조", "여포", "동탁", "초선", "손견"]//데이터는 한곳에만 있어야함 addview binding
    
    var body: some View {
       NavigationView(content: {
           ScrollView(content: {//<<<<<<<,//가로3
               LazyVGrid(columns: Array(repeating: GridItem(), count: 3),spacing: 10, content: {ForEach(dataArray, id: \.self, content: {item in
                NavigationLink(destination: DetailView(heroName: item), label: {
                    Text(item)//<<<<<<<<<<<<<<<<모델 아니라 . 필요없음
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                    //폰의 크기가 다르기 때문 크기에 맞춰 3개 infinity
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.buttonBorder)
                })//중복추가 안되기때문에 중복추가 하기위해서 모델 만들어야함?
             })//self 안보여주기 때문에 append??
            })//모델 id,//item for문 안의 변수
               .padding()//<<<<<<<<<<<<<<<<
           })
           .navigationTitle("삼국지 인물")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar(content: {
               ToolbarItem(placement:.topBarTrailing, content: {
                   NavigationLink(destination: AddView(dataArray: $dataArray), label: {
                       //화면 넘길때 버튼
                       Image(systemName: "plus")
                   })
               })
           })
       })
    }
}

#Preview {
    ContentView()
}
//모델 필요없음 타이틀만 필요
//data array string

