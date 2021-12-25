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
                print(filePath)
                print(data)
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
            print("decode error")
            print(error)
            
        }
    }
    
}
