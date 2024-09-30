import SwiftUI

struct CategoryView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 0
        )
    }
    
    var category: Category
    
    var body: some View {
        HStack {
            VStack(spacing: 8) {
                HStack {
                    Text(category.name)
                        .font(Constant.AppFont.primary)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Spacer()
                }
                if let description = category.description {
                    HStack {
                        Text(description)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            Spacer()
            UrlImageView(
                urlString: category.imageUrl,
                width: 125,
                height: 125
            )
        }
        .padding(Const.viewInsets)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .clipped()
    }
    
}

#Preview {
    CategoryView(category: Category(
        id: 1,
        name: "Платья",
        description: "Самые красивые и легкие, что Вы носили",
        imageUrl: "https://example.com/images/tshirt1.png"
    )
    )
}
