import SwiftUI

enum AuthViewRouter {
    case orders, favorites
}

struct AuthView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink("Orders", value: AuthViewRouter.orders)
                NavigationLink("Favorites", value: AuthViewRouter.favorites)
            }
            .navigationTitle("Auth User View")
            .navigationDestination(for: AuthViewRouter.self) { destination in
                switch destination {
                case .orders:
                    // TODO: Add Orders View
                    Text("Orders View")
                case .favorites:
                    // TODO: Add Favorites View
                    Text("Favorites View")
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
