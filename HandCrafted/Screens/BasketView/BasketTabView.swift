import SwiftUI

struct BasketTabView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        NavigationView {
            BasketView()
                .navigationDestination(for: AppDestination.self) { destination in
                    switch destination {
                    case .detail(let product):
                        ProductDetailView(product: product)
                    default:
                        Text("Ошибка роутинга 🙀")
                    }
                }
        }
    }
}

#Preview {
    BasketTabView()
        .environmentObject(AppRouter())
        .environmentObject(BasketViewModel())
}
