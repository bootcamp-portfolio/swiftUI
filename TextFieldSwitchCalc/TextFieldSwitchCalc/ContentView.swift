import SwiftUI

struct ContentView: View {
    
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    
    @State private var isAddOn: Bool = false
    @State private var isSubOn: Bool = false
    @State private var isMulOn: Bool = false
    @State private var isDivOn: Bool = false
    
    @State private var addResult: String = ""
    @State private var subResult: String = ""
    @State private var mulResult: String = ""
    @State private var divResult: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("간단한 계산기")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                VStack(spacing: 15) {
                    HStack {
                        Text("첫번째 숫자 :")
                            .frame(width: 100, alignment: .leading)
                        
                        TextField("0", text: $firstNumber)
                            .textFieldStyle(.roundedBorder)
                            #if os(iOS)
                            .keyboardType(.decimalPad)
                            #endif
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("두번째 숫자 :")
                            .frame(width: 100, alignment: .leading)
                        
                        TextField("0", text: $secondNumber)
                            .textFieldStyle(.roundedBorder)
                            #if os(iOS)
                            .keyboardType(.decimalPad)
                            #endif
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.horizontal, 30)
                
                HStack(spacing: 20) {//가로배치
                    Button(action: {
                        calculate()
                    }) {
                        Text("계산하기")
                            .frame(width: 110, height: 45)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        clearAll()
                    }) {
                        Text("지우기")
                            .frame(width: 110, height: 45)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                VStack(spacing: 12) {
                    HStack(spacing: 30) {
                        HStack {
                            Text("덧셈")
                                .frame(width: 50, alignment: .leading)
                            Toggle("", isOn: $isAddOn)
                                .labelsHidden()
                        }
                        
                        HStack {
                            Text("뺄셈")
                                .frame(width: 50, alignment: .leading)
                            Toggle("", isOn: $isSubOn)
                                .labelsHidden()
                        }
                    }
                    
                    HStack(spacing: 30) {
                        HStack {
                            Text("곱셈")
                                .frame(width: 50, alignment: .leading)
                            Toggle("", isOn: $isMulOn)
                                .labelsHidden()
                        }
                        
                        HStack {
                            Text("나눗셈")
                                .frame(width: 50, alignment: .leading)
                            Toggle("", isOn: $isDivOn)
                                .labelsHidden()
                        }
                    }
                }
                .padding(16)
                .background(Color.gray.opacity(0.08))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 15) {
                    resultRow(title: "덧셈 :", value: addResult, placeholder: "덧셈 결과")
                    resultRow(title: "뺄셈 :", value: subResult, placeholder: "뺄셈 결과")
                    resultRow(title: "곱셈 :", value: mulResult, placeholder: "곱셈 결과")
                    resultRow(title: "나눗셈 :", value: divResult, placeholder: "나눗셈 결과")
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
        }
    }
    
    // 결과 표시용 행
    func resultRow(title: String, value: String, placeholder: String) -> some View {
        HStack {
            Text(title)
                .frame(width: 70, alignment: .leading)
            
            Text(value.isEmpty ? placeholder : value)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 10)
                .frame(height: 35)
                .background(Color.gray.opacity(0.15))
                .foregroundColor(value.isEmpty ? .gray : .black)
                .cornerRadius(8)
        }
    }
    
    // 계산 함수
    func calculate() {
        guard let num1 = Double(firstNumber),
              let num2 = Double(secondNumber) else {
            addResult = ""
            subResult = ""
            mulResult = ""
            divResult = ""
            return
        }
        
        if isAddOn {
            addResult = String(format: "%.1f", num1 + num2)
        } else {
            addResult = ""
        }
        
        if isSubOn {
            subResult = String(format: "%.1f", num1 - num2)
        } else {
            subResult = ""
        }
        
        if isMulOn {
            mulResult = String(format: "%.1f", num1 * num2)
        } else {
            mulResult = ""
        }
        
        if isDivOn {
            if num2 == 0 {
                divResult = "0으로 나눌 수 없음"
            } else {
                divResult = String(format: "%.6f", num1 / num2)
            }
        } else {
            divResult = ""
        }
    }
    
    // 전체 초기화 함수
    func clearAll() {
        firstNumber = ""
        secondNumber = ""
        
        isAddOn = false
        isSubOn = false
        isMulOn = false
        isDivOn = false
        
        addResult = ""
        subResult = ""
        mulResult = ""
        divResult = ""
    }
}

#Preview {
    ContentView()
}
