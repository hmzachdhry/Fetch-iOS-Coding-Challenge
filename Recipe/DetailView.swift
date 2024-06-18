import SwiftUI

struct DetailView: View {
    let mealID: String
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ScrollView {
            if let meal = viewModel.selectedMeal {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<20, id: \.self) { index in
                            if let ingredient = viewModel.getIngredient(for: meal, index: index),
                               let measure = viewModel.getMeasure(for: meal, index: index),
                               !ingredient.isEmpty, !measure.isEmpty {
                                HStack(alignment: .top) {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                        .padding(.trailing, 4)
                                    Text("\(ingredient): \(measure)")
                                        .fixedSize(horizontal: false, vertical: true) // Allow multiline
                                }
                                .padding(.bottom, 4)
                            }
                        }
                    }
                    
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    let instructions = meal.strInstructions?.components(separatedBy: "\r\n").filter { !$0.isEmpty } ?? []
                    
                    ForEach(instructions.indices, id: \.self) { index in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .fontWeight(.bold)
                                .padding(.trailing, 4)
                            Text(instructions[index])
                                .fixedSize(horizontal: false, vertical: true) // Allow multiline
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding()
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchMealDetails(by: mealID)
                    }
            }
        }
        .navigationTitle(viewModel.selectedMeal?.strMeal ?? "Loading...")
        .onAppear {
            viewModel.fetchMealDetails(by: mealID)
        }
    }
}
