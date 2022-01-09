//
//  Category.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import SwiftUI


struct Category : Codable, Hashable {
    let type : String
}

extension Category {
    static let categories : [Category] = [
        Category(type: CategoryTypes.business.rawValue),
        Category(type: CategoryTypes.entertainment.rawValue),
        Category(type: CategoryTypes.general.rawValue),
        Category(type: CategoryTypes.health.rawValue),
        Category(type: CategoryTypes.science.rawValue),
        Category(type: CategoryTypes.sports.rawValue),
        Category(type: CategoryTypes.technology.rawValue)
    ]
    
    static func parseCategoryToEnum (category: String) -> CategoryTypes {
        
        switch category.uppercased() {
            case CategoryTypes.business.rawValue.uppercased():
                return CategoryTypes.business
                
            case CategoryTypes.entertainment.rawValue.uppercased():
                return CategoryTypes.entertainment
                
            case CategoryTypes.general.rawValue.uppercased():
                return CategoryTypes.general
                
            case CategoryTypes.health.rawValue.uppercased():
                return CategoryTypes.health
                
            case CategoryTypes.science.rawValue.uppercased():
                return CategoryTypes.science
                
            case CategoryTypes.technology.rawValue.uppercased():
                return CategoryTypes.technology
                
            case CategoryTypes.sports.rawValue.uppercased():
                return CategoryTypes.sports
                
            default:
                print("\(category) default --")
                return CategoryTypes.general
        }
    }
    
    static func persistCategories (categories: [Category]) {
        
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(categories)

            UserDefaults.standard.set(data, forKey: _UserProfileKeys.categories)
            
            
            print("Persisted Categories")

        } catch {
            print("Unable to Encode Categories (\(error))")
        }
        
    }
    
    static func getCategoriesFromUD () -> [Category] {
       
        if let data = UserDefaults.standard.data(forKey: _UserProfileKeys.categories) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let data = try decoder.decode([Category].self, from: data)
                
                return data
                
            } catch {
                print("Unable to Decode Categories (\(error))")
                return []
            }
        } else { return [] }
    }
    
}


