//
//  ContentView.swift
//  ServerJsonImageList
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI
import SDWebImageSwiftUI//<<<<<<<<<<<<<<,

struct ContentView: View {
    @State var movies: [MovieJSON] = []
    @State var image: UIImage?
    
    var body: some View {
       NavigationView(content: {
           List(movies, id: \.title, rowContent: { movie in
               HStack(content: {
                   WebImage(url: URL(string: movie.image))
                       .resizable()
                       .scaledToFit()
                       .frame(width: 100, height: 100)
                       .cornerRadius(20)
                   
                   Text(movie.title)
                   
                   Spacer()
               })//<<<<<<<<<<<<import
           })
           .navigationTitle("영화 리스트")
           .onAppear{
               let queryModel = QueryModel()
               Task{
                   movies = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/movies.json")!)//<<<<<<<<<fastapi
                   //ios json 키값안씀 result 생략
               }
           }
       })
    }
}

#Preview {
    ContentView()
}
