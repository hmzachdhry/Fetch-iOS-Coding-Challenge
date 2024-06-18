import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    
    func fetchDessertMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let urlString = "\(baseUrl)filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
                completion(.success(decodedResponse.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetails(by id: String, completion: @escaping (Result<Meal, Error>) -> Void) {
        let urlString = "\(baseUrl)lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let meal = decodedResponse.meals.first {
                    completion(.success(meal))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
