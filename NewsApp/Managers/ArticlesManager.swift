//
//  ArticlesManager.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import Foundation

final class ArticlesManager {
    
    static let shared = ArticlesManager()
    public var selectedSources: [String] = []
    private var sources: [NewsSource] = []
    private var articlesToShow: [Article] = []
    
    
    private init() { }
    
    //MARK: - Private
    
    /// Check if the current category already exists in our categories array if not appent it.
    private func doesCategoryExistInArray(category: String, categories: [String]) -> Bool {
        for i in 0..<categories.count {
            if category == categories[i] {
                return true
            }
        }
        return false
    }
    
    /// Check if the current category already exists in our categories array if not appent it.
    private func doesSourceExistInArray(source: NewsSource, sources: [NewsSource]) -> Bool {
        for i in 0..<sources.count {
            if source.name == sources[i].name {
                return true
            }
        }
        return false
    }
    
    /// Get news sources names from articles array
    private func getSourcesFromArticles(articles: [Article]) -> [NewsSource] {
        var sourcesFromArticles: [NewsSource] = []
        for i in 0..<articles.count {
            let source = NewsSource(
                id: nil,
                name: articles[i].source.name ?? "",
                description: nil,
                url: nil,
                category: nil,
                language: nil,
                country: nil)
            if sourcesFromArticles.count == 0 {
                sourcesFromArticles.append(source)
            } else {
                if doesSourceExistInArray(source: source, sources: sourcesFromArticles) == false {
                    sourcesFromArticles.append(source)
                }
            }
        }
        return sourcesFromArticles
    }
    
    /// Check if selected sources id is nil or not
    private func checkSelectedSourceId(for source: String, sources: [NewsSource]) -> String? {
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
        for i in 0..<selectedSources.count {
            if let source = checkSelectedSourceId(for: selectedSources[i], sources: sources) {
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
                            if self.selectedSources[i] == newArticles[j].source.name {
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
        self.selectedSources = []
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
                            self.sources.append(contentsOf: self.getSourcesFromArticles(articles: newResponse.articles))
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
        APIManager.shared.getCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                for source in response.sources {
                    guard let category = source.category else { return }
                    if categories.count == 0 {
                        categories.append(category)
                    } else {
                        if self.doesCategoryExistInArray(category: category, categories: categories) == false {
                            categories.append(category)
                        }
                    }
                }
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    /// Get all top headlines for selected sources and selected country.
    public func getArticlesForSelectedSources(for articles: [Article]) -> [Article] {
        var articlesToShow: [Article] = []
        for i in 0..<selectedSources.count {
            for j in 0..<articles.count {
                if selectedSources[i] == articles[j].source.name {
                    articlesToShow.append(articles[j])
                }
            }
        }
        return articlesToShow
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
