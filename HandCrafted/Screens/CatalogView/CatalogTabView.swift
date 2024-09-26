import SwiftUI

struct CatalogTabView: View {
    
    @StateObject var catalogViewModel = CatalogViewModel()
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
        .environmentObject(catalogViewModel)
    }
}

#Preview {
    CatalogTabView()
        .environmentObject(AppRouter())
}
