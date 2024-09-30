import SwiftUI

struct CatalogTabView: View {
    
    @StateObject var catVm = CatalogViewModel()
    
    @EnvironmentObject var basVm: BasketViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        NavigationStack(path: $appRouter.navPath) {
            CatalogView()
                .navigationDestination(for: AppDestination.self) { destination in
                    switch destination {
                    case .list(let category):
                        ProductListView(category: category)
                    case .detail(let product):
                        ProductDetailView(product: product)
                    default:
                        Text("Ошибка роутинга 🙀")
                    }
                }
        }
        .environmentObject(catVm)
    }
}

#Preview {
    CatalogTabView()
        .environmentObject(AppRouter())
        .environmentObject(BasketViewModel())
}
