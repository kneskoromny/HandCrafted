import SwiftUI

struct TabsView: View {
    
    @State private var selection = 3
    
    var body: some View {
        TabView(selection: $selection) {
            CatalogView()
                .tabItem {
                    Label(
                        "Catalog",
                        systemImage: "book"
                    )
                }
                .tag(1)
            BasketView()
                .tabItem {
                    Label(
                        "Basket",
                        systemImage: "basket"
                    )
                }
                .tag(2)
            ProfileTabView()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person"
                    )
                }
                .tag(3)
            
        }
    }
}

#Preview {
    TabsView()
}
