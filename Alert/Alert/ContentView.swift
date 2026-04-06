import SwiftUI

struct ContentView: View {

@State private var isLampOn: Bool = true
@State private var showOnAlert: Bool = false
@State private var showOffAlert: Bool = false
@State private var showRemoveDialog: Bool = false

var body: some View {
    VStack {

        Spacer()

        Text("Alert")
            .font(.headline)
            .padding(.bottom, 20)

        Image(isLampOn ? "lamp_on" : "lamp_off")
            .resizable()
            .scaledToFit()
            .frame(width: 180, height: 260)
            .foregroundColor(isLampOn ? .yellow : .gray)
            .padding(.bottom, 40)

        Spacer()

        HStack(spacing: 40) {

            Button("켜기") {
                if isLampOn {
                    showOnAlert = true
                } else {
                    isLampOn = true
                }
            }

            Button("끄기") {
                if isLampOn {
                    showOffAlert = true
                }
            }

            Button("제거") {
                showRemoveDialog = true
            }
        }
        .font(.system(size: 16, weight: .medium))
        .padding(.bottom, 30)
    }
    .padding()

    // 1. 현재 켜져 있을 때 다시 켜기 누름
    .alert("현재 On 상태 입니다.", isPresented: $showOnAlert) {
        Button("네, 알겠습니다.", role: .cancel) { }
    }

    // 2. 끄기 확인 Alert
    .alert("램프를 끄겠습니까?", isPresented: $showOffAlert) {
        Button("아니오", role: .cancel) { }
        Button("네") {
            isLampOn = false
        }
    }

    // 3. 제거 확인 Alert//dialog
    .alert("램프를 제거 할까요?", isPresented: $showRemoveDialog) {
        Button("아니오, 끕니다") {
            isLampOn = false
        }

        Button("아니오, 켭니다") {
            isLampOn = true
        }

        Button("네, 제거합니다", role: .destructive) {
            isLampOn = false
        }

        Button("취소", role: .cancel) { }
    }
}


}

#Preview {
ContentView()
}

