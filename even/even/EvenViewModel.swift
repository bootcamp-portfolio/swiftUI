import Foundation
import Combine
import SwiftUI

final class EvenViewModel: ObservableObject {
    // Inputs as text from TextFields
    @Published var firstNumberText: String = "" {
        didSet { validate() }
    }
    @Published var secondNumberText: String = "" {
        didSet { validate() }
    }

    // Output / UI-facing state
    @Published private(set) var statusText: String = ""
    @Published private(set) var isActionEnabled: Bool = false
    @Published private(set) var lastSum: Int? = nil

    private enum ValidationState {
        case empty
        case invalidRange
        case notNumber
        case notEven
        case valid
    }

    // Configuration
    private let allowedRange: ClosedRange<Int> = 0...99

    // Derived parsed values
    var firstNumber: Int? { Int(firstNumberText) }
    var secondNumber: Int? { Int(secondNumberText) }

    func updateFirst(_ text: String) {
        firstNumberText = text
    }

    func updateSecond(_ text: String) {
        secondNumberText = text
    }

    func reset() {
        firstNumberText = ""
        secondNumberText = ""
        statusText = ""
        isActionEnabled = false
        lastSum = nil
    }

    func run() {
        // Validate inputs and produce detailed message
        let state = validateState()
        switch state {
        case .empty:
            statusText = "숫자를 입력해주세요"
            isActionEnabled = false
            return
        case .notNumber:
            statusText = "올바른 숫자를 입력하세요"
            isActionEnabled = false
            return
        case .invalidRange:
            statusText = "0부터 99 사이의 숫자를 입력하세요"
            isActionEnabled = false
            return
        case .notEven:
            statusText = guidanceForOddInputs()
            return
        case .valid:
            break
        }

        // Safe to compute
        let sum = (firstNumber ?? 0) + (secondNumber ?? 0)
        lastSum = sum
        statusText = "합계: \(sum)"
    }

    private func validate() {
        switch validateState() {
        case .valid:
            isActionEnabled = true
        default:
            isActionEnabled = false
        }
    }

    private func isEven(_ n: Int) -> Bool { n % 2 == 0 }

    private func validateState() -> ValidationState {
        // Empty
        if firstNumberText.isEmpty || secondNumberText.isEmpty {
            return .empty
        }
        // Number parsing
        guard let a = firstNumber, let b = secondNumber else {
            return .notNumber
        }
        // Range
        guard allowedRange.contains(a), allowedRange.contains(b) else {
            return .invalidRange
        }
        // Even check
        guard isEven(a), isEven(b) else {
            return .notEven
        }
        return .valid
    }

    private func guidanceForOddInputs() -> String {
        let a = firstNumber
        let b = secondNumber
        switch (a?.isMultiple(of: 2) ?? false, b?.isMultiple(of: 2) ?? false) {
        case (false, true):
            return "첫번째 수가 홀수입니다. 짝수를 입력하세요"
        case (true, false):
            return "두번째 수가 홀수입니다. 짝수를 입력하세요"
        case (false, false):
            return "두 수 모두 홀수입니다. 짝수를 입력하세요"
        case (true, true):
            return ""
        }
    }
}
