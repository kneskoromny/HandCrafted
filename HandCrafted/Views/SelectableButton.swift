import SwiftUI

struct SelectableButton: View {
    
    var title: String?
    var font: Font
    var height: CGFloat = 24
    var disabled: Bool
    
    private var color: Color {
        return disabled ? .secondary : .primary
    }
    
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
            if !disabled {
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
        height: 44,
        disabled: false
    )
}
