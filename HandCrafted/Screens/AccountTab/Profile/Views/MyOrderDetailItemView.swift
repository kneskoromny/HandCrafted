import SwiftUI

// FIXME: Не работает


// TODO: Не сделано
// отображение цены распродажи

struct MyOrderDetailItemView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 16
        )
    }
    
    var orderItem: OrderItem
    
    var height: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            UrlImageView(
                urlString: orderItem.product.imageUrls?.first,
                width: height / 1.15,
                height: height
            )
            Spacer()
            VStack(spacing: 8) {
                HStack {
                    Text(orderItem.product.name)
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 8) {
                    if let selectedSize = orderItem.product.selectedSize?.name {
                    HStack(spacing: 4) {
                        Text("Размер: ")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(selectedSize)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                        }
                    }
                    HStack {
                        HStack(spacing: 4) {
                            Text("Цвет: ")
                                .font(Constant.AppFont.thirdly)
                                .foregroundStyle(.secondary)
                            Text(orderItem.product.color.name)
                                .font(Constant.AppFont.thirdly)
                                .foregroundStyle(.primary)
                        }
                    }
                    Spacer()
                }
                Spacer()
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("Количество: ")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(String(orderItem.quantity))
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                        
                    }
                    Spacer()
                    Text("\(orderItem.totalPrice) ₽")
                        .font(Constant.AppFont.secondary)
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
    MyOrderDetailItemView(
        orderItem: OrderItem(product: MockData.mockProduct, quantity: 2),
        height: 125
    )
}
