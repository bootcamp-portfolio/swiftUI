import SwiftUI

struct ReadOnlyRow: View {
    let title: String
    let value: String

    var body: some View {
        LabeledContent(title) {
            Text(value.isEmpty ? "" : value)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .accessibilityLabel(title)
        }
    }
}
