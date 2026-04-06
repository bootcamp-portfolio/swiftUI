import SwiftUI

struct ContentView: View {
    @State private var input: String = "" // 사용자 입력

    @State private var confirmedDan: Int? = nil // 버튼으로 확정된 단

    private var outputLines: [String] {
        guard let dan = confirmedDan, dan > 0 else { return [] }
        return (1...9).map { "\(dan) x \($0) = \(dan * $0)" }
    }

    var body: some View {
        VStack(spacing: 24) {
            // Header: Left title and right 'Next' button (disabled when no dan)
//            HStack {
//                Text("Quiz 01: 구구단?")
//                    .font(.headline)
//                    .foregroundStyle(.primary)
//                Spacer()
//                Button(action: onNext) {
//                    Text("다음")
//                        .font(.body)
//                }
//                .buttonStyle(.plain)
//                .disabled(selectedDan == nil)
//                .opacity(selectedDan == nil ? 0.4 : 1)
//            }

            // Center title and input field
            VStack(spacing: 12) {
                Text("구구단 출력")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    TextField("구구단", text: $input)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Button("단출력") {
                        if let dan = Int(input), dan > 0 {
                            confirmedDan = dan
                        } else {
                            confirmedDan = nil
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    if let dan = confirmedDan {
                        Text("\(dan)단")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            // Gray rounded box with generated lines
            VStack(alignment: .leading, spacing: 8) {
                if outputLines.isEmpty {
                    Text("숫자를 입력하면 구구단이 표시됩니다.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(outputLines, id: \.self) { line in
                        Text(line)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.gray.opacity(0.3))
            )

            Spacer(minLength: 0)
        }
        .padding(20)
    }

    private func onNext() {
        // TODO: Replace with actual navigation or logic
        // 현재는 입력 초기화만 수행
        input = ""
    }
}

#Preview {
    ContentView()
}
