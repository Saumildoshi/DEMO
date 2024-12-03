//
//  NetworkManager.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {} // Singleton pattern

    func fetchData<T: Codable>(
        urlString: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // Validate URL
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add headers
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Start data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle network error
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Check status code
            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.httpError(httpResponse.statusCode)))
                return
            }
            
            // Decode data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

// MARK: - HTTP Method Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

// MARK: - NetworkError Enum
enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case httpError(Int)
    case noData
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .invalidResponse:
            return "The server response was invalid."
        case .httpError(let statusCode):
            return "HTTP Error with status code: \(statusCode)"
        case .noData:
            return "No data received from the server."
        case .decodingError(let error):
            return "Failed to decode the data: \(error.localizedDescription)"
        }
    }
}


