//
//  SourcesResponse.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import Foundation

struct SourcesResponse: Codable {
    let sources: [NewsSource]
}

struct NewsSource: Codable {
    let id: String?
    let name: String
    let description: String?
    let url: URL?
    let category: String?
    let language: String?
    let country: String?
}
