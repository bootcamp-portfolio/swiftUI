//
//  ContentView.swift
//  DatePicker
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var currentDate = Date()
    @State var selectDate = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    // 날짜/시간 표시 형식 지정
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
        return formatter
    }
    
    // 알람 규칙에 따른 배경색 (기본은 흰색)
    var backgroundColor: Color {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        let second = Calendar.current.component(.second, from: currentDate)

        // 11시 33분: 홀수초 빨강, 짝수초 파랑
        if hour == 11 && minute == 33 {
            return (second % 2 == 0) ? .blue : .red
        }

        // 11시 34분: 흰색으로 복귀
        if hour == 11 && minute == 34 {
            return .white
        }

        // 기본 배경: 흰색
        return .white
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("현재시간 : \(currentDate, formatter: dateFormatter)")
                    .font(.title3)
                    .foregroundColor((backgroundColor == .red || backgroundColor == .blue) ? .white : .black)
                    .onReceive(timer) { input in
                        currentDate = input
                    }
                
                DatePicker(
                    "",
                    selection: $selectDate,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
                .padding()
                .background(.white.opacity(0.2))
                .cornerRadius(15)
                
                Text("선택시간 : \(selectDate, formatter: dateFormatter)")
                    .font(.title3)
                    .foregroundColor((backgroundColor == .red || backgroundColor == .blue) ? .white : .black)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
