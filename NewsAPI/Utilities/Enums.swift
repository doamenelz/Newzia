//
//  Enums.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-08.
//

import Foundation

enum SettingsCellType {
    
    case newsFeed
    case sources
    case categories
    case country
    case language
    
}

enum LanguageTypes : String {
    case english = "en"
    case french = "fr"
    case arabic = "ar"
}

enum NewsSortType : String {
    case popularity = "popularity"
    case relevancy = "relevancy"
    case publishedDate = "publishedAt"
    
}

