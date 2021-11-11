//
//  AppSettings.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 10.11.21..
//

import Foundation

final class AppSettings {
    
    static let shared = AppSettings()
    
    private init() { }
    
    public var selectedCategory: String = ""
    public var selectedCountryCode: String = ""
    public var selectedSources: [String] = []
    
}
