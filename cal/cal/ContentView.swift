//
//  ContentView.swift
//  cal
//
//  Created by electrozone on 3/26/26.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = CalculatorViewModel()
    @FocusState private var focusedField: Field?

    enum Field: Hashable { case first, second }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("두개의 숫자 연산")) {
                    VStack(alignment: .leading, spacing: 12) {
                        LabeledContent("첫번째 숫자 :") {
                            TextField("1st Number", text: $vm.firstInput)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .first)
                                .submitLabel(.next)
                                .onSubmit { focusedField = .second }
                        }
                        LabeledContent("두번째 숫자 :") {
                            TextField("2nd Number", text: $vm.secondInput)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .second)
                                .submitLabel(.done)
                        }
                        HStack(spacing: 16) {
                            Button("계산하기") { vm.calculate() }
                                .buttonStyle(.borderedProminent)
                            Button("초기화") {
                                vm.reset()
                                focusedField = .first
                            }
                                .buttonStyle(.bordered)
                        }
                    }
                }

                Section(header: Text("결과")) {
                    ReadOnlyRow(title: "덧셈 결과 :", value: vm.formatted(vm.sum))
                    ReadOnlyRow(title: "뺄셈 결과 :", value: vm.formatted(vm.difference))
                    ReadOnlyRow(title: "곱셈 결과 :", value: vm.formatted(vm.product))
                    ReadOnlyRow(title: "나눗셈 결과 :", value: vm.formatted(vm.quotient))
                    ReadOnlyRow(title: "나머지 결과 :", value: vm.formatted(vm.remainder))
                }

                if let message = vm.footerMessage() {
                    Section(footer: Text(message)) { EmptyView() }
                }
            }
            //.navigationTitle("두개의 숫자 연산")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("완료") { focusedField = nil }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

