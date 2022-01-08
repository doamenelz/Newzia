//
//  TopicsViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-06.
//

import Foundation
import Combine

class TopicsViewModel : ObservableObject {
    
    @Published var allNews = News.sampleNews
    
    @Published var apiResponse : NewsCompletionResponse?
    
    @Published var selectedNews : News?
        
    func checkForMatch (topics: [String], topic: String) -> Bool {
        if topics.contains(where: {$0.uppercased() == topic.uppercased()}) {
           return true
        } else {
            return false
        }
    }
    
    func searchHeadlines (sources: [Source], language: String, topic: String, sortBy: String) {
        
        let parameters = [
            "pageSize" : 100,
            "apiKey" : K.Keys.newsKey,
            "sortBy" : sortBy,
            "language" : language,
            "q" : topic,
        ] as [String : Any]
        
        let apiUtil = APINewsUtility(_parameters: parameters, url: K.URLs.everything)
        
        apiUtil.getNews(sources: sources) { [self] response in
            
            apiResponse = response
            
            print(apiUtil.parameters)
            
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
