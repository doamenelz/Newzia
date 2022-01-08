//
//  SearchPageViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import Foundation

class SearchPageViewModel : ObservableObject {
    
    @Published var allNews = [News]()
    
    @Published var apiResponse : NewsCompletionResponse?
    
    @Published var selectedNews : News?
    
    @Published var searchedText : String = ""
    
    @Published var searchInProgress : Bool = false
    
    @Published var printedSearch : String = ""
    
    func searchHeadlines (sources: [Source], country: String, language: String, sortBy: String) {
        
        let parameters = [
            "pageSize" : 100,
            "apiKey" : K.Keys.newsKey,
            "sortBy" : sortBy,
            "language" : language,
            "q" : searchedText,
        ] as [String : Any]
        
        let apiUtil = APINewsUtility(_parameters: parameters, url: K.URLs.everything)
        
        apiUtil.getNews(sources: sources) { [self] response in
            
            apiResponse = response
            
            print(apiUtil.parameters)
            
            searchInProgress = false
            
            if response.success {
                
                allNews = apiUtil.news
                apiResponse?.success = true
                
            } else {
                print("I failed to get recent news")
                apiResponse?.error = response.error
                apiResponse?.success = false
                
            }
            
        }
        
        
    }
    
    
}
