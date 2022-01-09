//
//  AppDataModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation

class AppDataModel : ObservableObject {
    
    var sourcesModel = SourcesModel()
    
    var countriesModel = CountryModel()
    
    
    init () {
        getAllAppSources()
    }
    
    
    func getAllAppSources () {
        
        do {
            let decodedData = try JSONDecoder().decode([Source].self,
                                                     from: sourcesModel.localData!)
            
            allAppSources = decodedData
            
        } catch {
            print(error)
            
        }
        
        
    }
    
    func getAllAppCountries () {
        
        
        
    }
    
    
}
    
