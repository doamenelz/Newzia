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
    
    
    static func changeSourcesToString (sources: [Source]) -> String {
        
        var concatenated : [String] = []
        
        for source in sources {
            concatenated.append(source.id)
        }
        
        print(concatenated)
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
                    if item.category.uppercased() == cat.type.rawValue.uppercased() {
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
