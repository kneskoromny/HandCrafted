import SwiftUI

struct SelectableButton: View {
    
    var title: LocalizedStringKey
    var font: Font
    var foregroundColor: Color
    var backgroundColor: Color
    var height: CGFloat = 24
    var isSelectable: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .font(font)
                .padding(.leading)
            if isSelectable {
                Spacer()
                Image(uiImage: UIImage(named: "arrowDown")!)
                    .frame(width: height, height: height)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder()
                .tint(foregroundColor)
        }
            
    }
}

#Preview {
    SelectableButton(
        title: "Selectable Button",
        font: .body,
        foregroundColor: .black,
        backgroundColor: .white,
        height: 44,
        isSelectable: true
    )
}
