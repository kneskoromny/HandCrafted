import SwiftUI

struct MyOrdersView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var orders: [Order]
    
    var body: some View {
        List(orders) { order in
            Button {
                router.navigate(to: .orderDetail(order))
            } label: {
                MyOrderView(order: order)
            }
            .tint(.primary)
            .listRowInsets(EdgeInsets())
        }
        .navigationTitle("Мои заказы")
        .navigationBarBackButtonHidden()
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listRowSpacing(16)
        .contentMargins(.top, 24)
    }
}

#Preview {
    MyOrdersView(orders: [])
}
