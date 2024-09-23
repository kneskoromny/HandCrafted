import SwiftUI

struct BasketTabView: View {
    
    @ObservedObject var viewModel = BasketViewModel()
    @ObservedObject var router = BasketRouter()
    
    var body: some View {
        NavigationView {
            BasketView()
                .navigationDestination(for: BasketRouter.Destination.self) { destination in
                    switch destination {
                    case .detail(let product):
                        ProductDetailView(product: product)
                    }
                }
        }
        .environmentObject(viewModel)
        .environmentObject(router)
    }
}

#Preview {
    BasketTabView()
}
