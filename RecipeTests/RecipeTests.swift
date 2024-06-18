import XCTest
@testable import Recipe

class RecipeTests: XCTestCase {
    
    var viewModel: ContentViewModel!
    
    override func setUpWithError() throws {
        viewModel = ContentViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchDessertMeals() throws {
        let expectation = XCTestExpectation(description: "Fetch dessert meals")
        
        viewModel.fetchDessertMeals()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(self.viewModel.meals.isEmpty, "Failed to fetch dessert meals")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchMealDetails() throws {
        let mealID = "52777"
        
        let expectation = XCTestExpectation(description: "Fetch dessert details")
        
        viewModel.fetchMealDetails(by: mealID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.selectedMeal, "Failed to fetch dessert details")
            XCTAssertEqual(self.viewModel.selectedMeal?.idMeal, mealID, "Unexpected meal ID")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
