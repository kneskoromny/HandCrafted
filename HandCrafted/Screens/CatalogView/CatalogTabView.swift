import SwiftUI

struct CatalogTabView: View {
    
    @ObservedObject var catalogViewModel = CatalogViewModel()
    @ObservedObject var catalogRouter = CatalogRouter()
    
    var body: some View {
        NavigationStack(path: $catalogRouter.navPath) {
            CatalogView()
                .navigationDestination(for: CatalogRouter.Destination.self) { destination in
                    switch destination {
                    case .list(let category):
                        ProductListView(category: category)
                    case .detail(let product):
                        Text("Product Name: \(product.name)")
                    }
                }
        }
        .environmentObject(catalogViewModel)
        .environmentObject(catalogRouter)
    }
}

#Preview {
    CatalogTabView()
}
