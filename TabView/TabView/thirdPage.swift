
//  ContentView.swift
//  DatePicker

//

//  Created by electrozone on 3/30/26.

//

import SwiftUI

import Combine

struct thirdPage: View {

    @State var currentDate = Date()

    @State var selectDate = Date()

    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

    var dateFormatter: DateFormatter{

    let formatter = DateFormatter()

    formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"//소문자 대문자 24시 12시 설정

    return formatter

    }

    var body: some View {

    VStack {

    Text("현재시간 : \(currentDate, formatter: dateFormatter)")

    .onReceive(timer, perform: {input in currentDate = input})

    //DatePicker("", selection: $selectDate)

    }

    //Date()... :현재일 부터 미래만 선택가능

    //...Date():현재일부터 과거만 선택가능

    DatePicker("", selection: $selectDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])

    .labelsHidden().datePickerStyle(.wheel)// .compact, .graphical, .wheel

    .padding()

    Text("선택시간 : \(selectDate, formatter: dateFormatter)")

    }

}

#Preview {

thirdPage()

}
