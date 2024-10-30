import SwiftUI

struct MyOrdersView: View {
    
    @StateObject private var myOrdersVm = MyOrdersViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            if myOrdersVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(myOrdersVm.orders) { order in
                    Button {
                        router.navigate(to: .orderDetail(order))
                    } label: {
                        MyOrderView(order: order)
                    }
                    .tint(.primary)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listRowSpacing(16)
                .contentMargins(.top, 24)
            }
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
        .onAppear {
            myOrdersVm.getOrders()
        }
        
    }
}

#Preview {
    MyOrdersView()
}
