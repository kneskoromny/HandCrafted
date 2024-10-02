import SwiftUI

struct TabsView: View {
    
    @ObservedObject private var router = AppRouter()
    
    @StateObject private var catVm = CatalogViewModel()
    @StateObject private var basVm = BasketViewModel()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            CatalogTabView()
                .tabItem {
                    Label(
                        "Каталог",
                        systemImage: "book"
                    )
                }
                .tag(AppRouter.Tab.catalog)
            BasketTabView()
                .tabItem {
                    Label(
                        "Корзина",
                        systemImage: "basket"
                    )
                }
                .tag(AppRouter.Tab.cart)
                .badge(basVm.orderItems.count)
            ProfileTabView()
                .tabItem {
                    Label(
                        "Профиль",
                        systemImage: "person"
                    )
                }
                .tag(AppRouter.Tab.account)
        }
        .onChange(of: router.selectedTab) { newTab, oldTab in
            if newTab != oldTab {
                router.navPath = NavigationPath()
            }
        }
        .environmentObject(router)
        .environmentObject(basVm)
        .environmentObject(catVm)
        
    }
}

#Preview {
    TabsView()
}
