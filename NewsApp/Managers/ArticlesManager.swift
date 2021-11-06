//
//  ArticlesManager.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import Foundation

final class ArticlesManager {
    
    static let shared = ArticlesManager()
    public var articles: [Article] = []
    public var sources: [NewsSource] = []
    public var categories: [String] = []
    public var selectedSources: [String] = []
    public var articlesToShow: [Article] = []
    
    
    private init() { }
    
    //MARK: - Private
    
    /// Check if the current category already exists in our categories array if not appent it.
    private func doesCategoryExistInArray(category: String) -> Bool {
        for i in 0..<categories.count {
            if category == categories[i] {
                return true
            }
        }
        return false
    }
    
    /// Check if the current category already exists in our categories array if not appent it.
    private func doesSourceExistInArray(source: NewsSource) -> Bool {
        for i in 0..<sources.count {
            if source.name == sources[i].name {
                return true
            }
        }
        return false
    }
    
    /// Get news sources names from articles array
    private func getSourcesFromArticles(for country: String) {
        for i in 0..<articles.count {
            let source = NewsSource(
                id: nil,
                name: articles[i].source.name ?? "",
                description: nil,
                url: nil,
                category: nil,
                language: nil,
                country: country)
            if sources.count == 0 {
                sources.append(source)
            } else {
                if doesSourceExistInArray(source: source) == false {
                    sources.append(source)
                }
            }
        }
    }
    
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
    public func getTopHeadlines() {
        for i in 0..<selectedSources.count {
            if let source = checkSelectedSourceId(for: selectedSources[i]) {
                APIManager.shared.getTopHeadlines(for: source) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        self.articlesToShow.append(contentsOf: response.articles)
                    case.failure(let error):
                        print(error.localizedDescription)
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
                    case.failure(let error):
                        print(error.localizedDescription)
                    }

                }
            }
        }
    }
    
    
    /// Get all souces for a country, and a specific category if needed
    public func getSources(for country: String, category: String?) {
        self.sources = []
        APIManager.shared.getSources(for: country, category: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.sources.isEmpty == false {
                    self.sources = response.sources
                }
                guard !response.sources.isEmpty else {
                    APIManager.shared.getTopHeadlines(for: nil) { [weak self] newResult in
                        guard let self = self else { return }
                        switch newResult {
                        case .success(let newResponse):
                            self.articles = newResponse.articles
                            self.getSourcesFromArticles(for: country)
                        case.failure(let newError):
                            print(newError.localizedDescription)
                        }
                    }
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Get all selectable categories that user can select from the sources response we get
    public func getCategories() {
        getSources(for: "us", category: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            if self.sources.count != 0 {
                for source in self.sources {
                    guard let category = source.category else { return }
                    if self.categories.count == 0 {
                        self.categories.append(category)
                    } else {
                        if self.doesCategoryExistInArray(category: category) == false {
                            self.categories.append(category)
                        }
                    }
                }
            }
        }
    }
    
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

    
}
