import SwiftUI

struct SelectableButton: View {
    
    var title: String?
    var font: Font
    var color: Color
    var height: CGFloat = 24
    var isSelectable: Bool
    
    var body: some View {
        HStack {
            Text(title ?? "")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
                .background(Color(uiColor: .systemBackground))
                .foregroundColor(color)
                .font(font)
                .fontWeight(.semibold)
                .padding(.leading)
            Spacer()
            if isSelectable {
                Image(uiImage: UIImage(named: "arrowDown")!)
                    .frame(width: height, height: height)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder()
                .tint(color)
        }
            
    }
}

#Preview {
    SelectableButton(
        title: "Selectable Button",
        font: .body,
        color: .secondary,
        height: 44,
        isSelectable: true
    )
}
