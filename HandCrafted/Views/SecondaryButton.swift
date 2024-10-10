import SwiftUI

struct SecondaryButton: View {
    
    var title: String
    var font: Font
    var foregroundColor: Color
    var backgroundColor: Color
    var height: CGFloat = 24
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .font(font)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder()
                    .tint(foregroundColor)
            }
    }
}

#Preview {
    SecondaryButton(
        title: "Secondary Button",
        font: .body,
        foregroundColor: .black,
        backgroundColor: .white,
        height: 24
    )
}

