import Foundation
import SwiftUI

@Observable
final class CalculatorViewModel {
    // Inputs
    var firstInput: String = ""
    var secondInput: String = ""

    // Results
    var sum: Double? = nil
    var difference: Double? = nil
    var product: Double? = nil
    var quotient: Double? = nil
    var remainder: Double? = nil

    // MARK: - Actions
    func calculate() {
        guard let a = parse(firstInput), let b = parse(secondInput) else {
            clearResults()
            return
        }
        sum = a + b
        difference = a - b
        product = a * b
        if b != 0 {
            quotient = a / b
            remainder = a.truncatingRemainder(dividingBy: b)
        } else {
            quotient = nil
            remainder = nil
        }
    }

    func reset() {
        firstInput = ""
        secondInput = ""
        clearResults()
    }

    // MARK: - Helpers
    func footerMessage() -> String? {
        if firstInput.isEmpty && secondInput.isEmpty { return "" }
        if parse(firstInput) == nil || parse(secondInput) == nil {
            return "숫자만 입력하세요. 소수점도 가능합니다."
        }
        if let b = parse(secondInput), b == 0 {
            return "0으로 나눌 수 없습니다."
        }
        return nil
    }

    func formatted(_ value: Double?) -> String {
        guard let v = value else { return "" }
        if abs(v.rounded() - v) < 1e-10 { return String(Int(v.rounded())) }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: v)) ?? String(v)
    }

    private func parse(_ s: String) -> Double? {
        let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return Double(trimmed.replacingOccurrences(of: ",", with: ""))
    }

    private func clearResults() {
        sum = nil
        difference = nil
        product = nil
        quotient = nil
        remainder = nil
    }
}
