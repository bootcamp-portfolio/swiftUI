import SwiftUI

struct ContentView: View {
    @StateObject private var vm = AddressBookViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.items) { item in
                    ZStack(alignment: .leading) {
                        NavigationLink {
                            DetailView(address: item)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.gray)
                                .overlay(
                                    Group {
                                        if let name = item.imageName, !name.isEmpty {
                                            Image(name)
                                                .resizable()
                                                .scaledToFill()
                                        }
                                    }
                                )
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.phone)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 6)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            vm.deleteAddress(id: item.id) {}
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                    .contextMenu {
                        NavigationLink {
                            AddressFormView(vm: vm, mode: .edit(item))
                        } label: {
                            Label("수정", systemImage: "pencil")
                        }
                        Button(role: .destructive) {
                            vm.deleteAddress(id: item.id) {}
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("주소록")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddressFormView(
                            vm: vm,
                            mode: .add
                        )
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                vm.fetchAddresses()
            }
        }
    }
}
#Preview {
    NavigationStack {
        ContentView()
    }
}

