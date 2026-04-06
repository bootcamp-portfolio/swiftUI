import SwiftUI

struct ContentView: View {
    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            firstPage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Sun")
                }
                .tag(1)

            secondPage()
                .tabItem {
                    Image(systemName: "car")
                    Text("Sun&Snow")
                }
                .tag(2)

            thirdPage()
                .tabItem {
                    Image(systemName: "person")
                    Text("Sun&Snow")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
