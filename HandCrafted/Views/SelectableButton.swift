import SwiftUI

struct SelectableButton: View {
    
    var title: LocalizedStringKey
    var font: Font
    var height: CGFloat = 24
    var isSelectable: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
                .background(Color(uiColor: .systemBackground))
                .foregroundColor(isSelectable ? .primary : .secondary)
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
                .tint(isSelectable ? .primary : .secondary)
        }
            
    }
}

#Preview {
    SelectableButton(
        title: "Selectable Button",
        font: .body,
        height: 44,
        isSelectable: true
    )
}
