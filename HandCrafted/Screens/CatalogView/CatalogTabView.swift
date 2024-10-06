import SwiftUI

struct CatalogTabView: View {
    
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            CatalogView()
                .navigationDestination(for: AppDestination.self) { destination in
                    switch destination {
                    case .list(let category):
                        ProductListView(
                            category: category
                        )
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
    CatalogTabView()
        .environmentObject(AppRouter())
}
