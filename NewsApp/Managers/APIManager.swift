//
//  APIManager.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    public var selectedCategories: [String] = []
    public var selectedCountries: [String] =[]
    
    private init() { }
}
