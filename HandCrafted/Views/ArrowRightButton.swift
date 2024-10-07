import SwiftUI

struct ArrowRightButton: View {
    
    var title: String
    var subtitle: String?
    var font: Font
    var isSpacer: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(font)
                    .foregroundStyle(.black)
                if let subtitle {
                    Text(subtitle)
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.gray)
                }
            }
            if isSpacer {
                Spacer()
            }
            Image(systemName: "arrow.right")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ArrowRightButton(
        title: "My Orders",
        font: .title3,
        isSpacer: false
    )
}
