import SwiftUI

struct HandCraftedTabView: View {
    
    var body: some View {
        TabView {
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}

#Preview {
    HandCraftedTabView()
}
