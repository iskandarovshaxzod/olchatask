//
//  APIManager.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import Foundation
class APIManager {
    class func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let fetchedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
