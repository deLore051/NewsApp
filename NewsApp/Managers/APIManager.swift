//
//  APIManager.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum Purpose {
        case categories
        case sources
    }
    
    private init() { }
    
    /// Create a generic request that we can modify to call different API's
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping ((URLRequest) -> Void)) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Constansts.API.APIkey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    /// Get top headlines for a country, specific category in a country, single or multiple sources
    public func getTopHeadlines(for source: String?, completion: @escaping (Result<TopHeadlinesResponse, Error>) -> Void) {
        var url: String = Constansts.API.topHeadlinesAPIurl + AppSettings.shared.selectedCountryCode
        if let source = source {
            url = Constansts.API.topHeadlinesForSourceAPIurl + source
        }
        createRequest(with: URL(string: url), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    print("Failed to get top headlines")
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(TopHeadlinesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get sources for in the selected country
    public func getSources(completion: @escaping (Result<SourcesResponse, Error>) -> Void) {
        let url = Constansts.API.sourcesAPIurl + AppSettings.shared.selectedCountryCode + "&category=" + AppSettings.shared.selectedCategory
        createRequest(with: URL(string: url), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    print("Failed to get sources")
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SourcesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get available categories for sources
    public func getCategories(completion: @escaping (Result<SourcesResponse, Error>) -> Void) {
        let url = Constansts.API.sourcesAPIurl + "us"
        createRequest(with: URL(string: url), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    print("Failed to get sources")
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SourcesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
