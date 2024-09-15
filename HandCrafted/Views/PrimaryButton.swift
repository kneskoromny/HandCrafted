import SwiftUI

struct PrimaryButton: View {
    
    var title: LocalizedStringKey
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .font(.title3)
            .fontWeight(.semibold)
            .cornerRadius(8)
            .shadow(
                color: backgroundColor,
                radius: 1,
                x: 0,
                y: 0
            )

    }
}

#Preview {
    PrimaryButton(
        title: "Test Title",
        foregroundColor: .white,
        backgroundColor: .green
    )
}
