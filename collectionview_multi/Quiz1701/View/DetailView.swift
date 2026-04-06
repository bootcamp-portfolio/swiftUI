import SwiftUI

struct Animal: Identifiable {
    let id = UUID()
    let image: String
    let items: String
    let description: String
}

struct AnimalDetailView: View {
    let item: Animal

    var body: some View {
        VStack(spacing: 24) {
            Text(item.image)
                .font(.system(size: 120))
                .padding(.top, 40)

            Text(item.items)
                .font(.largeTitle)
                .bold()

            Text(item.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .navigationTitle(item.items)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnimalGridView: View {
    let data: [Animal] = [
        Animal(image: "🐝", items: "벌", description: "작은 벌입니다."),
        Animal(image: "🐯", items: "호랑이", description: "멋진 호랑이입니다."),
        Animal(image: "🦒", items: "기린", description: "목이 긴 기린입니다."),
        Animal(image: "🐶", items: "강아지", description: "귀여운 강아지입니다."),
        Animal(image: "🦊", items: "여우", description: "영리한 여우입니다."),
        Animal(image: "🦁", items: "사자", description: "용맹한 사자입니다."),
        Animal(image: "🐺", items: "늑대", description: "늑대는 무리지어 다닙니다."),
        Animal(image: "🐱", items: "고양이", description: "도도한 고양이입니다."),
        Animal(image: "🐻", items: "곰", description: "힘센 곰입니다.")
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(data) { (item: Animal) in
                        NavigationLink(destination: AnimalDetailView(item: item)) {
                            VStack(spacing: 8) {
                                Text(item.image)
                                    .font(.system(size: 56))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                Text(item.items)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Animal Grid")
        }
    }
}

#Preview {
    AnimalDetailView(item: Animal(image: "🐺", items: "늑대", description: "상세 화면 예시 설명입니다."))
}
#Preview("Grid") {
    AnimalGridView()
}

