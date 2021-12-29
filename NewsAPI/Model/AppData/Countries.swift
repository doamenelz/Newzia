//
//  Countries.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation

struct Country : Codable, Hashable {
    let name : String
    let code : String
    
}

extension Country {
    
    static let defaultCountry = Country(name: "United States", code: "us")
    
    static func persistCountry (country: Country) {
        
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(country)

            UserDefaults.standard.set(data, forKey: _UserProfileKeys.country)
            
            
            print("Persisted Country")

        } catch {
            print("Unable to Encode Country (\(error))")
        }
        
    }
    
    static func getCountryFromUD () -> Country? {
       
        if let data = UserDefaults.standard.data(forKey: _UserProfileKeys.country) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let data = try decoder.decode(Country.self, from: data)
                
                print("Country ---> \(data)")
                return data
                
            } catch {
                print("Unable to Decode Country (\(error))")
                return nil
            }
        } else { return nil }
    }
    
    
    
}

struct CountryVM : Identifiable {
    let id = UUID()
    let country : Country
}

class CountryModel : ObservableObject {
    
    @Published var localData : Data?
    
    @Published var countries = [Country]()
    
    @Published var comp : Bool = false
    
    @Published var selectedCountry : Country?
    
    init () {
        localData = readLocalFile(forName: "countries")
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(jsonData: Data) {
        
        do {
            let decodedData = try JSONDecoder().decode([Country].self,
                                                       from: jsonData)
            countries = decodedData
            
            
        } catch {
            print(error)
            
        }
    }
    
}
