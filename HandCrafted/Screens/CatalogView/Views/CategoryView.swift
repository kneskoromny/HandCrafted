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
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                if let description = category.description {
                    HStack {
                        Text(description)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            Spacer()
            if let urlString = category.imageUrl,
               let url = URL(string: urlString) {
                AsyncImage(url: url,
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                           placeholder: {
                    ProgressView()
                })
                .frame(width: 125, height: 125)
            } else {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundStyle(.white)
                    Text("👗")
                        .font(.largeTitle)
                }
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            }
        }
        .padding(Const.viewInsets)
        .background(Color.white)
        .cornerRadius(10)
        .clipped()
    }
    
}

#Preview {
    CategoryView(category: Category(
        name: "Платья",
        description: "Самые красивые и легкие, что Вы носили",
        imageUrl: "https://example.com/images/tshirt1.png"
    )
    )
}
