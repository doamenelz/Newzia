//
//  Sources.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import Foundation
import SwiftUI


//TODO: Sort Sources by selected Categories

struct Source : Codable, Hashable {
    let id : String
    let name : String
    let description : String
    let url : String
    let category : String
    let language : String
    let country : String
}

extension Source {
    static let sampleSources : [Source] = [Source(id: "id", name: "BBC News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sagittis dolor eget eros elementum porta. Nam laoreet, diam a malesuada mollis, arcu odio egestas sapien, ac finibus enim erat et neque. Sed pretium volutpat neque nec elementum. Pellentesque habitant morbi tristique senectus et ", url: "www.bbc.com", category: "general", language: "en", country: "gb")]
    
    
    static func persistSource (sources: [Source]) {
        
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(sources)

            UserDefaults.standard.set(data, forKey: _UserProfileKeys.sources)
            
            
            print("Persisted Sources")

        } catch {
            print("Unable to Encode sources (\(error))")
        }
        
    }
    
    static func getSourcesFromUD () -> [Source] {
       
        if let data = UserDefaults.standard.data(forKey: _UserProfileKeys.sources) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let data = try decoder.decode([Source].self, from: data)
                
                return data
                
            } catch {
                print("Unable to Decode Sources (\(error))")
                return []
            }
        } else { return [] }
    }
}

extension Source {
    
    
    static func changeSourcesToString (sources: [Source]) -> String {
        
        var concatenated : [String] = []
        
        for source in sources {
            concatenated.append(source.id)
        }
        
        return concatenated.joined(separator: ",")
    }
    
    
}


class SourcesModel : ObservableObject {
    
    @Published var sources = [Source]()
    
    @Published var localData : Data?
    
    init () {
        
        localData = readLocalFile(forName: "sources")
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
    
    func parse(jsonData: Data, category: [Category]) {
        
        var parsedSources = [Source]()
        
        do {
            let decodedData = try JSONDecoder().decode([Source].self,
                                                       from: jsonData)
            
            for item in decodedData {
                for cat in category {
                    if item.category.uppercased() == cat.type.uppercased() {
                        parsedSources.append(item)
                    }
                }
                
                
            }
            sources = parsedSources
            
        } catch {
            print(error)
            
        }
    }
    
}

var allAppSources = [Source]()
