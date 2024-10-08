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
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listRowSpacing(16)
                .contentMargins(.top, 24)
                
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
