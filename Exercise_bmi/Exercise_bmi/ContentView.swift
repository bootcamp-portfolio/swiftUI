import SwiftUI

struct ContentView: View {
    @State private var selectedHeight: Int = 170
    @State private var selectedWeight: Int = 73

    @State private var bmiResult: Double = 0.0
    @State private var resultText: String = ""
    @State private var selectedCategory: BMICategory? = nil

    let heights = Array(140...200)
    let weights = Array(30...150)

    var body: some View {
        VStack(spacing: 20) {
            Text("BMI 측정기")
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)

            HStack(alignment: .top) {
                VStack(spacing: 8) {
                    Text("신장(Cm)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Picker("신장", selection: $selectedHeight) {
                        ForEach(heights, id: \.self) { height in
                            Text("\(height)")
                                .tag(height)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 140, height: 150)
                    .clipped()
                }

                Spacer(minLength: 16)

                VStack(spacing: 8) {
                    Text("몸무게(Kg)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    Picker("몸무게", selection: $selectedWeight) {
                        ForEach(weights, id: \.self) { weight in
                            Text("\(weight)")
                                .tag(weight)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 140, height: 150)
                    .clipped()
                }
            }
            .padding(.top, 20)

            HStack {
                Spacer()
                Button {
                    calculateBMI()
                } label: {
                    Text("계산하기")
                        .foregroundColor(.white)
                        .frame(width: 160, height: 40)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }

            if !resultText.isEmpty {
                Text(resultText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            // 결과에 맞는 사진 1장만 표시
            if let category = selectedCategory {
                VStack(spacing: 10) {
                    Image(category.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)

                    Text(category.koreanName)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .padding(.top, 40)
            }

            Spacer()
        }
        .padding()
    }

    private func calculateBMI() {
        let heightMeter = Double(selectedHeight) / 100.0
        let weight = Double(selectedWeight)
        let bmi = weight / (heightMeter * heightMeter)

        bmiResult = bmi
        let category = bmiCategory(for: bmi)
        selectedCategory = category

        resultText = "귀하의 bmi 지수는 \(String(format: "%.2f", bmi))이고 \(category.koreanName)입니다."
    }

    private func bmiCategory(for bmi: Double) -> BMICategory {
        switch bmi {
        case ..<18.5:
            return .underweight
        case 18.5..<23.0:
            return .normal
        case 23.0..<25.0:
            return .overweight
        case 25.0..<30.0:
            return .obese
        default:
            return .severeObese
        }
    }
}

enum BMICategory {
    case underweight
    case normal
    case overweight
    case obese
    case severeObese

    var koreanName: String {
        switch self {
        case .underweight: return "저체중"
        case .normal: return "정상체중"
        case .overweight: return "과체중"
        case .obese: return "비만"
        case .severeObese: return "고도비만"
        }
    }

    var imageName: String {
        switch self {
        case .underweight: return "underweight"
        case .normal: return "normal"
        case .overweight: return "overweight"
        case .obese: return "obese"
        case .severeObese: return "severeObese"
        }
    }
}

#Preview {
    ContentView()
}
