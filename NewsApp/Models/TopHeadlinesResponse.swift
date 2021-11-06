//
//  TopHeadlinesResponse.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import Foundation

struct TopHeadlinesResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source : Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String?
}

