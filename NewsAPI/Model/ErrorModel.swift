//
//  ErrorModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation

struct ErrorModel : Codable {
    let status : String
    let code : String
    let message : String
}

extension ErrorModel {
    
    static func parseErrorModel (jsonData: Data) -> ErrorModel {
        
        do {
            
            let decodedData = try JSONDecoder().decode(ErrorModel.self,
                                                       from: jsonData)
            
            return decodedData
            
            
        } catch {
            print(error)
            return ErrorModel(status: "Failed", code: "32", message: error.localizedDescription)
        }
        
        
    }
    
    
}

