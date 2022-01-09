//
//  DiscoverFollowingViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import Foundation
import Alamofire

class SourcesProfilePageViewModel : ObservableObject {
    
    @Published var allNews = [News]()
    
    @Published var apiResponse : NewsCompletionResponse?
    
    @Published var selectedNews : News?

    
    func topHeadlines (sources: [Source], language: String) {
        
        let parameters = [
            "sources" : Source.changeSourcesToString(sources: sources),
            "pageSize" : 100,
            "apiKey" : K.Keys.newsKey,
            "language" : language
        ] as [String : Any]
        
        let apiUtil = APINewsUtility(_parameters: parameters, url: K.URLs.everything)
        
        apiUtil.getNews(sources: sources) { [self] response in
            
            apiResponse = response
            
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
    
    func checkForFollow (source: Source, sources: [Source]) -> Bool {
        
        if sources.contains(where: {$0.id == source.id}) {
            return true
        } else {
            return false
        }
    }
    
        
}


