import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    
    var body: some View {
        VStack {
            if basVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(basVm.orderItems) { orderItem in
                    Button {} label: {
                        BasketOrderItemView(
                            orderItem: orderItem,
                            height: 125
                        )
                    }
                    .tint(.primary)
                    .listRowInsets(EdgeInsets())
                }
                .scrollIndicators(.hidden)
                .contentMargins(16)
                .listRowSpacing(16)
                .listStyle(.insetGrouped)
                
            }
        }
        .navigationTitle("Корзина")
        .navigationBarBackButtonHidden()
        .alert(
            "Удалить?",
            isPresented: $basVm.isAlertPresented) {
                Button("Отмена", role: .cancel) {}
                Button("Удалить") {
                    basVm.removeOrderItem()
                }
            } message: {
                Text("Вы точно хотите удалить товар из Корзины?")
            }

    }
}

#Preview {
    BasketView()
        .environmentObject(BasketViewModel())
}
