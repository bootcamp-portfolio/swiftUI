import SwiftUI

struct ContentView: View {
    @StateObject var vm = AddressViewModel()
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.items, id: \.id) { item in
                    NavigationLink {
                        EditView(vm: vm, item: item)
                    } label: {
                        HStack {
                            Image(item.imageName.isEmpty ? "defaultProfile" : item.imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.phone)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        vm.deleteItem(item: vm.items[index])
                    }
                }
            }
            .navigationTitle("Main View")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddView = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddView(vm: vm)
            }
        }
    }
}
