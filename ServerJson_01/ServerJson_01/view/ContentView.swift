import SwiftUI


struct ContentView: View {
    
    @State var students: [StudentJSON] = []
    
    var body: some View {
      NavigationView(content: {
          List(students, id: \.code, rowContent: {student in
              VStack(alignment: .leading, content: {
                  Text("성명 : \(student.name)")
                  Text("학번 : \(student.code)")
                      .font(.system(size: 14))
              })
          })
          .navigationTitle("Students")
      })
      .padding()
      .onAppear(perform: {
          let queryModel = QueryModel()
          Task{
              students = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/student.json")!)
          }
      })//쿼리 넘길때 받기위해 인스턴스
    }
}

#Preview {
    ContentView()
}//async를 파스크? 안에
