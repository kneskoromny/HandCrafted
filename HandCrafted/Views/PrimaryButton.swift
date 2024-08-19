import SwiftUI

struct PrimaryButton: View {
    
    var title: LocalizedStringKey
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                height: 50
            )
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .font(.title3)
            .fontWeight(.semibold)
            .cornerRadius(10)
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
