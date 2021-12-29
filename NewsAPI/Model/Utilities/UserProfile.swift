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
    @Published var sources : [Source] = Source.getSourcesFromUD()
    //@Published var username : String = ""
    @Published var avatar = UIImage()
    //@Published var email : String = ""
    
    //@Published var isSignedIn : Bool = false
    
    //@Published var preferredNewsLanguage : String = "en"
    
    func setUserProfile (categories: [Category], sources: [Source], avatar: UIImage, username: String, country: Country) {
        self.categories = categories
        self.sources = sources
        self.avatar = avatar
        self.username = username
        self.country = country
        
        Source.persistSource(sources: sources)
        Category.persistCategories(categories: categories)
        Country.persistCountry(country: country)
        
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
    
    
    
    @Published var name : String = UserDefaults.standard.string(forKey: _UserProfileKeys.name) ?? "" {
        didSet {
            UserDefaults.standard.set(self.name, forKey: _UserProfileKeys.name)
        }
        
    }
    
    @Published var username : String = UserDefaults.standard.string(forKey: _UserProfileKeys.username) ?? "" {
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
    
}

    
    
    

