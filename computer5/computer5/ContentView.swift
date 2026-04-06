//
//  ContentView.swift
//  computer5
//
//  Created by electrozone on 3/26/26.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Text("Computer 사양 출력하기")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            HStack(spacing: 20) {

                // 1️⃣ 초기 화면
                PhoneView(
                    title: "초기화면",
                    product: "",
                    size: "",
                    weight: "",
                    bag: "",
                    color: "",
                    isResult: false
                )

                // 2️⃣ OK 버튼
                PhoneView(
                    title: "OK 버튼",
                    product: "맥북프로",
                    size: "16",
                    weight: "2.56",
                    bag: "false",
                    color: "백",
                    isResult: true
                )

                // 3️⃣ Clear 버튼
                PhoneView(
                    title: "Clear 버튼",
                    product: "",
                    size: "",
                    weight: "",
                    bag: "",
                    color: "",
                    isResult: false
                )
            }
        }
        .padding()
    }
}

struct PhoneView: View {
    var title: String
    var product: String
    var size: String
    var weight: String
    var bag: String
    var color: String
    var isResult: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)

            TextField("제품명 입력", text: .constant(product))
                .textFieldStyle(.roundedBorder)

            TextField("크기 입력", text: .constant(size))
                .textFieldStyle(.roundedBorder)

            TextField("무게 입력", text: .constant(weight))
                .textFieldStyle(.roundedBorder)

            TextField("가방여부 입력", text: .constant(bag))
                .textFieldStyle(.roundedBorder)

            TextField("색상 입력", text: .constant(color))
                .textFieldStyle(.roundedBorder)

            HStack {
                Button("OK") {}
                Button("Clear") {}
            }
            .padding(.top, 5)

            if isResult {
                Text("\(product)")
                Text("\(size)")
                Text("\(weight)")
                Text("\(bag)")
                Text("\(color)")
            }
        }
        .padding()
        .frame(width: 200)
        .border(Color.black)
    }
}

#Preview {
    ContentView()
}
