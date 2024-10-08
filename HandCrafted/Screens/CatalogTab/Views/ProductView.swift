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
            UrlImageView(
                urlString: product.imageUrls?.first,
                width: 150,
                height: 175
            )
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
                if let salePrice = product.price.sale {
                    Text(String(product.price.standard))
                        .strikethrough()
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.black)
                    Text("\(salePrice) ₽")
                        .font(Constant.AppFont.thirdly)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                } else {
                    Text("\(product.price.standard) ₽")
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.black)
                }
                Spacer()
            }
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: 150)
    }
}

#Preview {
    ProductView(product: MockData.mockProduct)
}
