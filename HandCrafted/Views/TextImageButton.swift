import SwiftUI

struct TextImageButton: View {
    
    var title: LocalizedStringKey
    var imageName: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.black)
            Image(
                ImageResource(
                    name: imageName ?? "",
                    bundle: Bundle.main
                )
            )
        }
    }
}

#Preview {
    TextImageButton(
        title: "test title",
        imageName: "arrowRight"
    )
}
