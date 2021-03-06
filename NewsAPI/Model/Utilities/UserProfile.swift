//
//  UserProfile.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import Foundation
import Combine
import SwiftUI

class UserProfile : ObservableObject {
    //@Published var name : String = ""
    @Published var country : Country = Country.getCountryFromUD() ?? Country(name: "United States", code: "us")
    
    @Published var categories : [Category] = Category.getCategoriesFromUD()
    
    @Published var sources : [Source] = Source.getSourcesFromUD().sorted(by: {$0.name < $1.name})
    
    @Published var avatar = UIImage()
    
    
    
    
    
    
    @Published var topics : [String] = UserDefaults.standard.stringArray(forKey: _UserProfileKeys.topics) ?? [] {
        didSet {
            UserDefaults.standard.set(self.topics, forKey: _UserProfileKeys.topics)
        }
        
    }
    
    @Published var recentSearches : [String] = UserDefaults.standard.stringArray(forKey: _UserProfileKeys.recentSearches) ?? [] {
        didSet {
            UserDefaults.standard.set(self.recentSearches, forKey: _UserProfileKeys.recentSearches)
        }

    }
    
    @Published var language : String = UserDefaults.standard.string(forKey: _UserProfileKeys.language) ?? "en" {
        didSet {
            UserDefaults.standard.set(self.language, forKey: _UserProfileKeys.language)
        }
        
    }
    
    @Published var sortParameter : String = UserDefaults.standard.string(forKey: _UserProfileKeys.sortParameter) ?? NewsSortType.publishedDate.rawValue {
        didSet {
            UserDefaults.standard.set(self.sortParameter, forKey: _UserProfileKeys.sortParameter)
        }
        
    }
    
    @Published var name : String = UserDefaults.standard.string(forKey: _UserProfileKeys.name) ?? "" {
        didSet {
            UserDefaults.standard.set(self.name, forKey: _UserProfileKeys.name)
        }
        
    }
    
    @Published var username : String = UserDefaults.standard.string(forKey: _UserProfileKeys.username) ?? "doamenelz" {
        didSet {
            UserDefaults.standard.set(self.username, forKey: _UserProfileKeys.username)
        }
        
    }
    
    @Published var email : String = UserDefaults.standard.string(forKey: _UserProfileKeys.email) ?? "" {
        didSet {
            UserDefaults.standard.set(self.email, forKey: _UserProfileKeys.email)
        }
        
    }
    
    @Published var isSignedIn : Bool = UserDefaults.standard.bool(forKey: _UserProfileKeys.isSignedIn) {
        didSet {
            UserDefaults.standard.set(self.isSignedIn, forKey: _UserProfileKeys.isSignedIn)
        }
    }
    
    @Published var preferredNewsLanguage : String = UserDefaults.standard.string(forKey: _UserProfileKeys.preferredNewsLanguage) ?? "en" {
        didSet {
            UserDefaults.standard.set(self.preferredNewsLanguage, forKey: _UserProfileKeys.preferredNewsLanguage)
        }
        
    }

    @Published var bookmarks = News.getBookmarkFromUD()
    
    var avatarURL: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("avatar.png")
    }
}

extension UserProfile {
    
    func persistAvatar () {
        if let data = avatar.pngData() {
            // Create URL
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("avatar.png")

            do {
                // Write to Disk
                try data.write(to: url)

                // Store URL in User Defaults
                UserDefaults.standard.set(url, forKey: "background")

            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
        
        
    }
    
    
    func setUserProfile (categories: [Category], sources: [Source], avatar: UIImage, username: String, country: Country, name: String) {
        self.categories = categories
        self.sources = sources
        self.avatar = avatar
        self.username = username
        self.country = country
        self.name = name
        
        Source.persistSource(sources: sources)
        Category.persistCategories(categories: categories)
        Country.persistCountry(country: country)
        
        persistAvatar()
        
    }
    
}



    
