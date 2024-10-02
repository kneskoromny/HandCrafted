import SwiftUI

struct CatalogView: View {
    
    // MARK: - State
    
    @EnvironmentObject var catVm: CatalogViewModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            if catVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(catVm.categoryList) { category in
                    Button {
                        router.navigate(to: .list(category: category))
                    } label: {
                        CategoryView(category: category)
                    }
                    .tint(.primary)
                    .listRowInsets(EdgeInsets())
                }
                .scrollIndicators(.hidden)
                .contentMargins(16)
                .listRowSpacing(16)
                .listStyle(.insetGrouped)
                
            }
        }
        .navigationTitle("Каталог")
        .navigationBarBackButtonHidden()
        .onAppear {
            catVm.fetchData()
        }
    }
}

#Preview {
    CatalogView()
        .environmentObject(CatalogViewModel())
        .environmentObject(AppRouter())
}
