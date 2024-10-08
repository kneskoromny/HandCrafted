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
        .listRowSpacing(16)
        .contentMargins(.top, 24)
    }
}

#Preview {
    MyOrdersView(orders: [])
}
