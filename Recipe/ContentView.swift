import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: DetailView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchDessertMeals()
            }
        }
    }
}
