import SwiftUI

struct ContentView: View {
//@State private var isOff: Bool = false
//@State private var isRed: Bool = false
EnvironmentObject var lamp
    
var body: some View {
    NavigationStack {
        VStack {
            Spacer()

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 220)

            Spacer()
        }
        .navigationTitle("메인화면")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    LampControlView(isOff: $isOff, isRed: $isRed)
                } label: {
                    Image(systemName: "lightbulb")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

var imageName: String {
    if isOff {
        return "lamp_off"
    } else if isRed {
        return "lamp_pink"
    } else {
        return "lamp_on"
    }
}

}

struct LampControlView: View {
@Binding var isOff: Bool
@Binding var isRed: Bool


var body: some View {
    VStack(spacing: 30) {
        Toggle("Off", isOn: $isOff)
            .padding(.horizontal, 40)

        Toggle("Red", isOn: $isRed)
            .padding(.horizontal, 40)
    }
    .padding(.top, 120)
    .navigationTitle("전구선택 화면")
    .navigationBarTitleDisplayMode(.inline)
}

}

#Preview {
ContentView()
}
