import SwiftUI

struct TabsView: View {
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            CatalogTabView()
                .tabItem {
                    Label(
                        "Каталог",
                        systemImage: "book"
                    )
                }
                .tag(1)
            BasketTabView()
                .tabItem {
                    Label(
                        "Корзина",
                        systemImage: "basket"
                    )
                }
                .tag(2)
            ProfileTabView()
                .tabItem {
                    Label(
                        "Профиль",
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
