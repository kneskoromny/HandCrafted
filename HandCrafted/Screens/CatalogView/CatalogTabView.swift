import SwiftUI

struct CatalogTabView: View {
    
    @ObservedObject var catalogViewModel = CatalogViewModel()
    @ObservedObject var catalogRouter = CatalogRouter()
    
    var body: some View {
        NavigationStack(path: $catalogRouter.navPath) {
            CatalogView()
                .navigationDestination(for: CatalogRouter.Destination.self) { destination in
                    switch destination {
                    case .list(let productList):
                        Text("Product List category: \(productList.first?.categoryName)")
                    case .detail(let product):
                        Text("Product Name: \(product.name)")
                    }
                }
                .environmentObject(catalogViewModel)
                .environmentObject(catalogRouter)
        }
    }
}

#Preview {
    CatalogTabView()
}
