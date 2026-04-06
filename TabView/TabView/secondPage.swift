//
//  SecondPage.swift
//  TabBarPage
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct secondPage: View {

@State var lampWidth: [CGFloat] = [320.0, 130.0]

@State var lampHeight: [CGFloat] = [500.0, 200.0]

@State var imageLamp: [String] = ["lamp_on", "lamp_off"]

@State var imageLargeSmallSeq: Int = 0

@State var toggleStatus: Bool = true

@State var sizeToggle: Bool = false // false: 확대, true: 축소

var body: some View {

VStack {

// 전구 이미지

Image(toggleStatus ? imageLamp[0] : imageLamp[1])

.resizable()

.frame(

width: lampWidth[imageLargeSmallSeq],

height: lampHeight[imageLargeSmallSeq]

)

.fixedSize()

.padding(.bottom, 100)

.frame(width: 400, height: 550)

HStack {

// 왼쪽: 전구확대 (텍스트 + 토글)

VStack(spacing: 5) {

Text("전구확대")

Toggle("", isOn: $sizeToggle)

.labelsHidden()

.onChange(of: sizeToggle) { _, newValue in

imageLargeSmallSeq = newValue ? 1 : 0

}

}

Spacer()

// 가운데: 버튼

Button("크기변경") {

if imageLargeSmallSeq == 0 {

imageLargeSmallSeq = 1

sizeToggle = true

} else {

imageLargeSmallSeq = 0

sizeToggle = false

}

}

Spacer()

// 오른쪽: 켜짐 / 꺼짐 (텍스트 + 토글)

VStack(spacing: 5) {

Text(toggleStatus ? "켜짐" : "꺼짐")

Toggle("", isOn: $toggleStatus)

.labelsHidden()

}

}

.padding(.horizontal, 30)

}

.padding()

}

}

#Preview {
    secondPage()
}
