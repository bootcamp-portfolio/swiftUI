import SwiftUI

struct ContentView: View {
    @State private var sentText: String = ""
    @State private var message: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            // 상단 제목
            Text("보낸내용")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 20)
                .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: 18) {
                // 큰 표시 박스: 보낸내용 표시, 키보드 내려가면(포커스 해제) 더 크게
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(.systemGray6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .frame(height: isFocused ? 150 : 220)
                        .animation(.easeInOut(duration: 0.2), value: isFocused)

                    ScrollView {
                        Text(sentText.isEmpty ? "(메시지가 여기에 표시됩니다)" : sentText)
                            .font(.system(size: 18))
                            .foregroundColor(sentText.isEmpty ? .secondary : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                    }
                }

                // 메세지 라벨
                Text("메세지")
                    .font(.system(size: 15, weight: .medium))

                // 입력창
                ZStack(alignment: .leading) {
                    if message.isEmpty {
                        Text("메세지를 입력하세요")
                            .foregroundColor(.secondary)
                            .padding(.leading, 14)
                    }
                    TextField("", text: $message, axis: .vertical)
                        .textFieldStyle(.plain)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .focused($isFocused)
                }
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .frame(minHeight: 38)

                // 이모지 + 보내기 한 줄 배치
                HStack(spacing: 16) {
                    Button(action: { message += "😀" }) { Text("😀").font(.system(size: 30)) }
                    Button(action: { message += "🥰" }) { Text("🥰").font(.system(size: 30)) }
                    Button(action: { message += "😎" }) { Text("😎").font(.system(size: 30)) }

                    Spacer()

                    Button(action: {
                        sentText = message
                        isFocused = false // 키보드 내리기
                    }) {
                        Text("보내기")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.3) : Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .disabled(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)

                Spacer()
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .onTapGesture { isFocused = false }
    }
}

#Preview {
    ContentView()
}
