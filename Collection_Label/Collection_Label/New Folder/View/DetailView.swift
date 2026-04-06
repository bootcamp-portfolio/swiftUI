//
//  DetailView.swift
//  Collection_Label
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI

struct DetailView: View {
    
    var heroName: String
    
    var body: some View {
        VStack(content: {
            VStack(content: {
                Text(heroName)
            })
            .navigationTitle("인물 보기")
            .navigationBarTitleDisplayMode(.inline)
        })
    }
}

#Preview {
    DetailView(heroName: "James")
}//property
