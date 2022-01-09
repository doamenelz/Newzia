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

enum _UserProfileKeys {
    static let name = "name"
    static let country = "country"
    static let sources = "sources"
    static let username = "username"
    static let avatar = "avatar"
    static let isSignedIn = "isSignedIn"
    static let preferredNewsLanguage = "preferredNewsLanguage"
    static let email = "email"
    static let categories = "categories"
    static let topics = "topics"
    static let recentSearches = "recentSearches"
    static let language = "language"
    static let bookmarks = "bookmarks"
    static let sortParameter = "newsSortParameter"
    
}

enum CategoryTypes : String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
}
