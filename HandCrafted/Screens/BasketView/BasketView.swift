import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var viewModel: BasketViewModel
    @EnvironmentObject var router: BasketRouter
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(viewModel.productList) { product in
                    Button {
                        router.navigate(to: .detail(product: product))
                    } label: {
                        Text(product.name)
                    }
                    .tint(Color.black)
                    .listRowInsets(EdgeInsets())
                }
                .scrollIndicators(.hidden)
                .contentMargins(16)
                .listRowSpacing(16)
                .listStyle(.insetGrouped)
                
            }
        }
        .navigationTitle("Моя корзина")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BasketView()
}
