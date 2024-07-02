import SwiftUI

struct HCButton: View {
    
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

    }
}

#Preview {
    HCButton(
        title: "Test Title",
        foregroundColor: .white,
        backgroundColor: .green
    )
}
