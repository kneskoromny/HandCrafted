import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var foregroundColor: Color = Color(uiColor: .systemBackground)
    var backgroundColor: Color = .red
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .font(Constant.AppFont.primary)
            .fontWeight(.bold)
            .cornerRadius(10)
    }
}

#Preview {
    PrimaryButton(title: "Войти")
}
