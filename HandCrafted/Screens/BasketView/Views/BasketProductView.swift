import SwiftUI

struct BasketProductView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 16
        )
    }
    
    @EnvironmentObject var basVm: BasketViewModel
    
    var product: Product
    var height: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            UrlImageView(
                urlString: product.imageUrls?.first,
                width: height / 1.15,
                height: height
            )
            Spacer()
            VStack(spacing: 8) {
                HStack {
                    Text(product.name)
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 8) {
                    if let selectedSize = product.selectedSize?.name {
                    HStack(spacing: 4) {
                        Text("Размер: ")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(selectedSize)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                        }
                    }
                    HStack(spacing: 4) {
                        Text("Цвет: ")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(product.color.name)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                        
                    }
                    Spacer()
                }
                Spacer()
                HStack(spacing: 16) {
                    Button {
                        
                    } label: {
                        QuantitySelectButton(text: "-")
                    }
                    .foregroundStyle(.primary)
                    Text("1")
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Button {
                        
                    } label: {
                        QuantitySelectButton(text: "+")
                    }
                    .foregroundStyle(.primary)
                    Spacer()
                    Text("1 ₽")
                        .font(Constant.AppFont.primary)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            }
        }
        .padding(Const.viewInsets)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .clipped()
        .frame(height: height)
    }
}

#Preview {
    BasketProductView(
        product: MockData.mockProduct,
        height: 125
    )
    .environmentObject(BasketViewModel())
}

struct QuantitySelectButton: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(uiColor: .systemBackground))
                .shadow(radius: 3, x: 0, y: 3)
            Text(text)
                .font(Constant.AppFont.secondary)
                .foregroundStyle(.primary)
        }
        .frame(width: 30, height: 30)
    }
}
