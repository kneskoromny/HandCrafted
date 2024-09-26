import SwiftUI

struct TabsView: View {
    
    @ObservedObject private var appRouter = AppRouter()
    
    var body: some View {
        TabView(selection: $appRouter.selectedTab) {
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
            ProfileTabView()
                .tabItem {
                    Label(
                        "Профиль",
                        systemImage: "person"
                    )
                }
                .tag(AppRouter.Tab.account)
        }
        .onChange(of: appRouter.selectedTab) { newTab, oldTab in
            if newTab != oldTab {
                appRouter.navPath = NavigationPath()
            }
        }
        .environmentObject(appRouter)
        
    }
}

#Preview {
    TabsView()
}
