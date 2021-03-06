//
//  NewsLandingViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import Foundation
import Combine
import Alamofire

class NewsLandingViewModel : ObservableObject {
    
    @Published var topHeadlines = [News]()
    
    @Published var apiResponse : NewsCompletion?
    
    @Published var selectedNews : News?
    
    func getTopHeadlines (sources: [Source], completion: @escaping (NewsCompletion) -> Void) {
        
        let parameters = [
           "sources" : Source.changeSourcesToString(sources: sources),
            //"sources" : "bleacher-report,espn",
            "pageSize" : 60,
            "apiKey" : K.Keys.newsKey
        ] as [String : Any]
        
        AF.request(K.URLs.topHeadings, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { [self] response in
            
            switch response.result {
                    
                case .success(_):
                    print("Successfully called the TopHeadlines ")
                    guard let data = response.data else {return}
                    
                    if response.response?.statusCode == 200 {
                        print("Calling parseNews")
                        
                        var allNews = [News]()
                        
                        do {
                            
                            let decodedData = try JSONDecoder().decode(_News.self,
                                                                       from: data)
                            
                            let articles = decodedData.articles
                            
                            for article in articles {
                                
                                for source in sources {
                                    
                                    if article.source.id != "" {
                                        
                                        if article.source.id == source.id {
                                            let news = News(news: article, category: Category.parseCategoryToEnum(category: source.category), iconURL: source.url)
                                            allNews.append(news)
                                            
                                        }
                                    } else {
                                        let news = News(news: article, category: .general, iconURL: "")
                                        allNews.append(news)
                                    }
                                }
                                
                            }
                            
                            topHeadlines = allNews
                            
                        } catch {
                            print(error)
                        }
                        
                        completion(NewsCompletion(success: true, error: nil))
                        
                    } else {
                        
                        let error = ErrorModel.parseErrorModel(jsonData: data)
                        completion(NewsCompletion(success: false, error: error))
                        
                    }
                    
                case .failure(_):
                    print("Failed the topHeadlines")
            }
            
            
            
        }
            
        
        
    }
    
    
}

