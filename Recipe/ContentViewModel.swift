import Foundation

class ContentViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: Meal? = nil
    
    private let networkManager = NetworkManager()
    
    func fetchDessertMeals() {
        networkManager.fetchDessertMeals { result in
            switch result {
            case .success(let mealList):
                DispatchQueue.main.async {
                    self.meals = mealList.sorted { $0.strMeal < $1.strMeal }
                }
            case .failure(let error):
                print("Failed to fetch dessert meals: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMealDetails(by id: String) {
        networkManager.fetchMealDetails(by: id) { result in
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self.selectedMeal = meal
                }
            case .failure(let error):
                print("Failed to fetch meal details: \(error.localizedDescription)")
            }
        }
    }
    
    func getIngredient(for meal: Meal, index: Int) -> String? {
        switch index {
        case 0: return meal.strIngredient1
        case 1: return meal.strIngredient2
        case 2: return meal.strIngredient3
        case 3: return meal.strIngredient4
        case 4: return meal.strIngredient5
        case 5: return meal.strIngredient6
        case 6: return meal.strIngredient7
        case 7: return meal.strIngredient8
        case 8: return meal.strIngredient9
        case 9: return meal.strIngredient10
        case 10: return meal.strIngredient11
        case 11: return meal.strIngredient12
        case 12: return meal.strIngredient13
        case 13: return meal.strIngredient14
        case 14: return meal.strIngredient15
        case 15: return meal.strIngredient16
        case 16: return meal.strIngredient17
        case 17: return meal.strIngredient18
        case 18: return meal.strIngredient19
        case 19: return meal.strIngredient20
        default: return nil
        }
    }
    
    func getMeasure(for meal: Meal, index: Int) -> String? {
        switch index {
        case 0: return meal.strMeasure1
        case 1: return meal.strMeasure2
        case 2: return meal.strMeasure3
        case 3: return meal.strMeasure4
        case 4: return meal.strMeasure5
        case 5: return meal.strMeasure6
        case 6: return meal.strMeasure7
        case 7: return meal.strMeasure8
        case 8: return meal.strMeasure9
        case 9: return meal.strMeasure10
        case 10: return meal.strMeasure11
        case 11: return meal.strMeasure12
        case 12: return meal.strMeasure13
        case 13: return meal.strMeasure14
        case 14: return meal.strMeasure15
        case 15: return meal.strMeasure16
        case 16: return meal.strMeasure17
        case 17: return meal.strMeasure18
        case 18: return meal.strMeasure19
        case 19: return meal.strMeasure20
        default: return nil
        }
    }
}
