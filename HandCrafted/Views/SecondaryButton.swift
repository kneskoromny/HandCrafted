import SwiftUI

struct SecondaryButton: View {
    
    var title: String
    var foregroundColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemBackground)
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .font(Constant.AppFont.primary)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(foregroundColor, lineWidth: 1)
            )
    }
}

#Preview {
    SecondaryButton(
        title: "Зарегистрироваться"
    )
}

