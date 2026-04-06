import SwiftUI

struct ContentView: View {
    
    @State var todoLists: [Animal] = [
        Animal(image: "bee", items: "벌", description: "이 동물의 이름은 벌이며 이 벌은 꿀을 모으는 곤충입니다."),
        Animal(image: "cat", items: "고양이", description: "이 동물의 이름은 고양이이며 포유류입니다."),
        Animal(image: "cow", items: "젖소", description: "이 동물의 이름은 젖소이며 포유류입니다."),
        Animal(image: "dog", items: "강아지", description: "이 동물의 이름은 강아지이며 귀여운 포유류입니다."),
        Animal(image: "fox", items: "여우", description: "이 동물의 이름은 여우이며 포유류입니다."),
        Animal(image: "monkey", items: "원숭이", description: "이 동물의 이름은 원숭이이며 포유류입니다."),
        Animal(image: "pig", items: "돼지", description: "이 동물의 이름은 돼지이며 포유류입니다."),
        Animal(image: "wolf", items: "늑대", description: "이 동물의 이름은 늑대이며 이 늑대는 육식을 하는 포유류입니다.")
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 35) {
                    ForEach(todoLists) { animal in
                        NavigationLink(destination: AnimalListDetailView(animal: animal)) {
                            VStack(spacing: 8) {
                                Image(animal.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                
                                Text(animal.items)
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                            }
                            .frame(maxWidth: .infinity, minHeight: 95)
                        }
                    }
                }
                .padding(.horizontal, 35)
                .padding(.top, 25)
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AnimalListDetailView: View {
    let animal: Animal

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(animal.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text(animal.items)
                .font(.title2)
                .bold()
            Text(animal.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    ContentView()
}
