import SwiftUI

struct BasketTabView: View {
    
    @StateObject var viewModel = BasketViewModel()
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
        .environmentObject(viewModel)
    }
}

#Preview {
    BasketTabView()
        .environmentObject(AppRouter())
}
