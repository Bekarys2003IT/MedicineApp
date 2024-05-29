//
//  NetworkManager.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 06.05.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchSafetyReport(completion: @escaping (Result<[SafetyReport], Error>) -> Void) {
        // Replace this with your API endpoint
        guard let url = URL(string:"https://api.fda.gov/drug/event.json?api_key=cOQSeB76JUHfNu2j6C6m3Q9IQFjnQDAs7Bp47HXu") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let response = try JSONDecoder().decode(SafetyReportResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
