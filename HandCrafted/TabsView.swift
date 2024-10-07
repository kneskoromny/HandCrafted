import SwiftUI

struct TabsView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
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
                .badge(basVm.productItems.count)
            AccountTabView()
                .tabItem {
                    Label(
                        "Аккаунт",
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
        .onChange(of: scenePhase, { _, newValue in
            if newValue == .inactive {
                print(#function, "mytest - state change to inactive")
                basVm.saveOrderItems()
            }
        })
        .environmentObject(router)
        .environmentObject(basVm)
        .environmentObject(catVm)
        
    }
}

#Preview {
    TabsView()
}
