import SwiftUI

struct ProductView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 0
        )
    }
    
    var product: Product
    
    var body: some View {
        VStack {
            UrlImageView(product: product)
            HStack {
                Text(product.name)
                    .font(Constant.AppFont.secondary)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            HStack {
                Text(product.fabric)
                    .font(Constant.AppFont.thirdly)
                    .foregroundStyle(.gray)
                Spacer()
            }
            HStack {
                Text("\(product.price) ₽")
                    .font(Constant.AppFont.thirdly)
                    .foregroundStyle(.black)
                Spacer()
            }
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: 150)
    }
}

#Preview {
    ProductView(product: MockData.products.first!)
        .environmentObject(CatalogViewModel())
}

struct UrlImageView: View {
    
    var product: Product
    
    var body: some View {
        if let imageUrl = product.imageUrls?.first,
           let url = URL(string: imageUrl) {
            AsyncImage(url: url,
                       content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
                       placeholder: {
                ProgressView()
            })
            .frame(width: 150, height: 175)
            .clipped()
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
    
}
