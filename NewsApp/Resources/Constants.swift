//
//  Constants.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import Foundation

struct Constansts {
    
    static let categoryImages = [
        "business_category_image",
        "entertainment_category_image",
        "general_category_image",
        "health_category_image",
        "science_category_image",
        "sports_category_image",
        "technology_category_image"
    ]
    
    static let categoryNames = [
        "Business",
        "Entertainment",
        "General",
        "Health",
        "Science",
        "Sports",
        "Technology"
    ]
    
    static let countrySourceNames: [String] = [
        "Argentina", "Australia", "Austria", "Belgium", "Brazil", "Bulgaria",
        "Canada", "China", "Columbia", "Cuba", "Czech Republic", "Egypt",
        "France", "Germany", "Greece", "Hong Kong", "Hungary", "India",
        "Indonesia", "Ireland", "Israel", "Italy", "Japan", "Latvia",
        "Lithuania", "Malaysia", "Mexico", "Morocco", "Netherlands", "New Zeland",
        "Nigeria", "Norway", "Philippines", "Poland", "Portugal", "Romania",
        "Russia", "Saudi Arabia", "Serbia", "Singapore", "Slovakia", "Slovenia",
        "South Africa", "South Korea", "Sweden", "Switzerland", "Taiwan", "Thailand",
        "Turkey", "UAE", "Ukraine", "United Kingdom", "United States", "Venezuela"
    ]
    
    static let countryCodes: [String] = [
        "ar", "au", "at", "be", "br", "bg",
        "ca", "cn", "co", "cu", "cz", "eg",
        "fr", "de", "gr", "hk", "hu", "in",
        "id", "ie", "il", "it", "jp", "lv",
        "lt", "my", "mx", "ma", "nl", "nz",
        "ng", "no", "ph", "pl", "pt", "ro",
        "ru", "sa", "rs", "sg", "sk", "si",
        "za", "kr", "se", "ch", "tw", "th",
        "tr", "ae", "ua", "uk", "us", "ve"
    ]
    
    struct API {
        static let baseAPIurl = "https://newsapi.org/v2/"
        static let APIkey = "58ee9c69d06f40559da440c09b3dfaf1"
        static let topHeadlinesAPIurl = "https://newsapi.org/v2/top-headlines?country="
        static let sourcesAPIurl = "https://newsapi.org/v2/top-headlines/sources?country="
    }
}
