import SwiftUI

// TODO: не сделано
// конвертить дату

struct MyOrderView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var order: Order
    
    var totalItemsQuantity: Int {
        return order.items.reduce(0) { $0 + $1.quantity }
    }
    
    var status: OrderStatus? {
        return OrderStatus(rawValue: order.status)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(spacing: 8) {
                    HStack {
                        Text("Заказ №")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(order.id)
                            .font(Constant.AppFont.primary)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                }
                Spacer()
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text("Оформлен")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        
                    }
                    HStack {
                        Spacer()
                        Text(order.date)
                            .font(Constant.AppFont.primary)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                }
            }
            HStack {
                HStack {
                    Text("Товаров:")
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.secondary)
                    Text(String(totalItemsQuantity))
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                Spacer()
                HStack {
                    Text("Сумма:")
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.secondary)
                    Text("\(order.totalPrice ?? 0) ₽")
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
            }
            VStack(spacing: 8) {
                if let status {
                    MyOrderStatusView(status: status)
                        .frame(height: 44)
                }
                Button {
                    router.navigate(to: .orderDetail(order))
                } label: {
                    SecondaryButton(
                        title: "Детали",
                        font: Constant.AppFont.secondary,
                        foregroundColor: .primary,
                        backgroundColor: Color(uiColor: .systemBackground),
                        height: 36
                    )
//                    .frame(width: 150)
                }
                .tint(.primary)
            }
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .clipped()
    }
    
    
}

#Preview {
    MyOrderView(
        order: Order(
            id: "KLD-11222",
            userId: "dnsjdnksdnksjdkjasdij",
            status: OrderStatus.created.rawValue,
            totalPrice: 6500,
            date: "10-07-2024",
            items: [
                OrderItem(
                    product: MockData.mockProduct,
                    quantity: 2
                )
            ]
        )
    )
}
