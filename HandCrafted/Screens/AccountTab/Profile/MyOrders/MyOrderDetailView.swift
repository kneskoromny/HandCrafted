import SwiftUI

struct MyOrderDetailView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var order: Order
    
    private var totalItemsQuantity: Int {
        return order.items.reduce(0) { $0 + $1.quantity }
    }
    
    private var status: OrderStatus? {
        return OrderStatus(rawValue: order.status)
    }
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    HStack {
                        VStack(spacing: 4) {
                            HStack {
                                Text("Заказ №")
                                    .font(Constant.AppFont.thirdly)
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                            HStack {
                                Text(order.id)
                                    .font(Constant.AppFont.primary)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                Spacer()
                            }
                        }
                        Spacer()
                        VStack(spacing: 4) {
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
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            Section {
                ForEach(order.items) { item in
                    Button {} label: {
                        MyOrderDetailItemView(
                            orderItem: item,
                            height: 125
                        )
                    }
                    .tint(.primary)
                    .listRowInsets(EdgeInsets())
                }
                HStack {
                    Text("Cумма:")
                        .font(Constant.AppFont.secondary)
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("\(order.totalPrice) ₽")
                        .font(Constant.AppFont.primary)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            Section {
                if let status {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Статус вашего заказа:")
                                .font(Constant.AppFont.secondary)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(status.name.lowercased())
                                .font(Constant.AppFont.primary)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(uiColor: .systemGreen))
                        }
                        HStack {
                            Text(status.descriprtion)
                            .font(Constant.AppFont.secondary)
                            .foregroundStyle(.secondary)
                            Spacer()
                        }
                        
                    }
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Детали заказа")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.navigateBack()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listSectionSpacing(20)
        .listRowSpacing(16)
        .contentMargins(.top, 24)
    }
}

#Preview {
    MyOrderDetailView(
        order: Order(
            id: "КД2024-565",
            userId: "userId",
            status: 2,
            totalPrice: 7800,
            date: "10-10-2024",
            items: []
        )
    )
    .environmentObject(AppRouter())
}
