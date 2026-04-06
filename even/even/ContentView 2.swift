import SwiftUI

struct EvenScreen: View {
    @StateObject private var viewModel = EvenViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("짝수 검증 실행")
                .font(.headline)
                .padding(.top, 24)

            Group {
                HStack {
                    Text("첫번째 수:")
                    TextField("숫자 입력", text: Binding(
                        get: { viewModel.firstNumberText },
                        set: { viewModel.updateFirst($0) }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                }

                HStack {
                    Text("두번째 수:")
                    TextField("숫자 입력", text: Binding(
                        get: { viewModel.secondNumberText },
                        set: { viewModel.updateSecond($0) }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                }
            }

            Button(action: { viewModel.run() }) {
                Text("진행하기")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.isActionEnabled)

            Text(viewModel.statusText)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)

            Spacer()
        }
        .padding(24)
    }
}

#Preview {
    EvenScreen()
}
