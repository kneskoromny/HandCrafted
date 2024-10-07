import SwiftUI

// TODO: не сделано
// конвертить дату

struct MyOrderView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var order: Order
    
    var totalItemsQuantity: Int {
        return order.items.reduce(0) { $0 + $1.quantity }
    }
    
    var statusDescription: String {
        return OrderStatus(rawValue: order.status)?.description ?? ""
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Заказ № \(order.id)")
                    .font(Constant.AppFont.primary)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                Spacer()
                Text("10-07-2024")
                    .font(Constant.AppFont.primary)
                    .foregroundStyle(.secondary)
            }
            HStack {
                HStack {
                    Text("Количество: ")
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.secondary)
                    Text(String(totalItemsQuantity))
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                Spacer()
                HStack {
                    Text("Общая сумма: ")
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.secondary)
                    Text("\(order.totalPrice ?? 0) ₽")
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
            }
            HStack {
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
                    .frame(width: 150)
                }
                .tint(.primary)
                Spacer()
                Text(statusDescription)
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
