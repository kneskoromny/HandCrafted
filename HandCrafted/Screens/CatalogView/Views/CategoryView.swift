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
            Text(category.name)
                .font(Constant.AppFont.primary)
            Spacer()
            if let urlString = category.imageUrl,
               let url = URL(string: urlString) {
                AsyncImage(url: url,
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 175)
                },
                           placeholder: {
                    Image(category.name.lowercased(), bundle: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                })
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
        imageUrl: "https://example.com/images/tshirt1.png"
    )
    )
}
