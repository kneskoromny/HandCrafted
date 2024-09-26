import SwiftUI

struct CatalogView: View {
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: CatalogViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                List(viewModel.categoryList) { category in
                    Button {
                        appRouter.navigate(to: .list(category: category))
                    } label: {
                        CategoryView(category: category)
                    }
                    .tint(Color.black)
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
            viewModel.fetchData()
        }
    }
}

#Preview {
    CatalogView()
        .environmentObject(CatalogViewModel())
        .environmentObject(AppRouter())
}
