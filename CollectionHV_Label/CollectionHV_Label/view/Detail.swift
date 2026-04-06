//
//  DetailView.swift
//  CollectionViewHV_Label
//

import SwiftUI

struct DetailView: View {
    
    let heroName: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(heroName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .navigationTitle("상세 화면")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(heroName: "유비")
}
