//
//  ArticlesManager.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import Foundation

final class ArticlesManager {
    
    static let shared = ArticlesManager()
    private var sources: [NewsSource] = []
    private var articlesToShow: [Article] = []
    
    
    private init() { }
    
    //MARK: - Private
    
    /// Check if selected sources id is nil or not
    private func checkSelectedSourceId(for source: String) -> String? {
        for i in 0..<sources.count {
            if source == sources[i].name {
                if sources[i].id != "", sources[i].id != nil {
                    return sources[i].id!
                }
            }
        }
        return nil
    }
    
    //MARK: - Public
    
    /// Get top headlines for selected country
    public func getTopHeadlines(completion: @escaping (Result<[Article], Error>) -> Void) {
        self.articlesToShow = []
        for i in 0..<AppSettings.shared.selectedSources.count {
            if let source = checkSelectedSourceId(for: AppSettings.shared.selectedSources[i]) {
                APIManager.shared.getTopHeadlines(for: source) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        self.articlesToShow.append(contentsOf: response.articles)
                        completion(.success(self.articlesToShow))
                    case.failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                APIManager.shared.getTopHeadlines(for: nil) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        let newArticles = response.articles
                        for j in 0..<newArticles.count {
                            if AppSettings.shared.selectedSources[i] == newArticles[j].source.name {
                                self.articlesToShow.append(newArticles[j])
                            }
                        }
                        completion(.success(self.articlesToShow))
                    case.failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    
    /// Get all souces for a country, and a specific category if needed
    public func getSources(completion: @escaping (Result<[NewsSource], Error>) -> Void) {
        self.sources = []
        AppSettings.shared.selectedSources = []
        APIManager.shared.getSources() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.sources.isEmpty == false {
                    self.sources.append(contentsOf: response.sources)
                    completion(.success(response.sources))
                } else {
                    APIManager.shared.getTopHeadlines(for: nil) { [weak self] newResult in
                        guard let self = self else { return }
                        switch newResult {
                        case .success(let newResponse):
                            let unfilteredSourceNames = newResponse.articles.compactMap { $0.source.name }
                            let sourceNames = Array(Set(unfilteredSourceNames)).sorted()
                            self.sources = sourceNames.compactMap({
                                NewsSource(id: nil,
                                           name: $0.description,
                                           description: nil,
                                           url: nil,
                                           category: nil,
                                           language: nil,
                                           country: nil)
                            })
                            //self.sources.append(contentsOf: self.getSourcesFromArticles(articles: newResponse.articles))
                            completion(.success(self.sources))
                        case.failure(let newError):
                            completion(.failure(newError))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Get all selectable categories that user can select from the sources response we get
    public func getCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        var categories: [String] = []
        APIManager.shared.getCategories { result in
            switch result {
            case .success(let response):
                let unfilteredCategories = response.sources.compactMap({ $0.category })
                categories = Array(Set(unfilteredCategories)).sorted()
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    /// Check if articles imageToUrl propery is valid URL
    public func checkImageURL(for url: URL) -> URL? {
        var stringURL = url.description
        if stringURL.contains("//ocdn") {
            stringURL = "https:" + url.description
        }
        return URL(string: stringURL)
    }
    
}
