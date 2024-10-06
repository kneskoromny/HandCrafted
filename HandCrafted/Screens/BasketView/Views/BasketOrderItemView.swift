import SwiftUI

// FIXME: Не работает


// TODO: Не сделано
// отображение цены распродажи

struct BasketOrderItemView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 16
        )
    }
    
    @EnvironmentObject var basVm: BasketViewModel
    @StateObject var orderItem: OrderItem
    
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
                    HStack(spacing: 4) {
                        Text("Цвет: ")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(orderItem.product.color.name)
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                        
                    }
                    Spacer()
                }
                Spacer()
                HStack(spacing: 16) {
                    Button {
                        basVm.selectedItem = orderItem
                        if orderItem.quantity == 1 {
                            basVm.isAlertPresented = true
                        } else {
                            basVm.reduceQuantity()
                            basVm.calculateTotalPrice()
                        }
                    } label: {
                        QuantitySelectButton(text: "-")
                    }
                    .foregroundStyle(.primary)
                    Text("\(orderItem.quantity)")
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Button {
                        basVm.selectedItem = orderItem
                        basVm.increaseQuantity()
                        basVm.calculateTotalPrice()
                    } label: {
                        QuantitySelectButton(text: "+")
                    }
                    .foregroundStyle(.primary)
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
    BasketOrderItemView(
        orderItem: OrderItem(
            product: MockData.mockProduct,
            quantity: 1
        ),
        height: 125
    )
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
