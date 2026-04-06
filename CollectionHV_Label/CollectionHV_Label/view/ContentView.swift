//
//  ContentView.swift
//  CollectionViewHV_Label
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var dataArray: [String] = [
        "유비", "관우", "장비", "조조",
        "여포", "동탁", "초선", "손견"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                
                // 위쪽 : 세로 스크롤 + 3열 그리드
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                        spacing: 10
                    ) {
                        ForEach(dataArray, id: \.self) { item in
                            NavigationLink(destination: DetailView(heroName: item)) {
                                Text(item)
                                    .frame(maxWidth: .infinity, minHeight: 80)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 260)
                
                // 아래쪽 : 가로 스크롤
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(dataArray, id: \.self) { item in
                            NavigationLink(destination: DetailView(heroName: item)) {
                                Text(item)
                                    .frame(width: 80, height: 50)
                                    .background(.green)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 80)
                
                Spacer()
            }
            .navigationTitle("삼국지 인물")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddView(dataArray: $dataArray)) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
