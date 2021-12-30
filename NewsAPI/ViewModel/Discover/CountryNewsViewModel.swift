//
//  CountryNewsViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import Foundation

class CountryNewsViewModel : ObservableObject {
    
    @Published var allNews = [News]()
    
    @Published var apiResponse : NewsCompletionResponse?
    
    @Published var selectedNews : News?
    
    func topHeadlines (sources: [Source], country: String) {
        
        let parameters = [
            "pageSize" : 100,
            "country" : country,
            "apiKey" : K.Keys.newsKey,
        ] as [String : Any]
        
        let apiUtil = APINewsUtility(_parameters: parameters, url: K.URLs.topHeadings)
        
        apiUtil.getNews(sources: sources) { [self] response in
            
            apiResponse = response
            
            print(apiUtil.parameters)
            
            if response.success {
                
                allNews = apiUtil.news
                apiResponse?.success = true
                //parsePerCell(source: sources)
                
                
            } else {
                print("I failed to get recent news")
                apiResponse?.error = response.error
                apiResponse?.success = false
                
            }
            
        }
        
        
    }
    
}
