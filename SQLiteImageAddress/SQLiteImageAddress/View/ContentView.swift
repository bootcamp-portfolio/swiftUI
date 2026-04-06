import SwiftUI

struct ContentView: View {
    
    @StateObject private var db = AddressDB()
    @State private var addresses: [Address] = []
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(addresses) { item in
                    NavigationLink {
                        DetailView(db: db, addressItem: item, onChange: loadData)
                    } label: {
                        HStack(spacing: 12) {
                            Image(uiImage: item.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.phone)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("주소록")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                loadData()
            }
            .sheet(isPresented: $isShowingAddView, onDismiss: {
                loadData()
            }) {
                AddView(db: db, onSave: loadData)
            }
        }
    }
    
    func loadData() {
        addresses = db.queryDB()
    }
}

#Preview {
    ContentView()
}
