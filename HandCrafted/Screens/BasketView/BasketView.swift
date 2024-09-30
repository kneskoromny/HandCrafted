import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        VStack {
            if basVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(basVm.productList) { product in
                    Button {
                        appRouter.navigate(to: .detail(product: product))
                    } label: {
                        BasketProductView(
                            product: product,
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
    }
}

#Preview {
    BasketView()
        .environmentObject(BasketViewModel())
        .environmentObject(AppRouter())
}
