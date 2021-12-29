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
    
    //@Published var following = [Following]()
    
//    func parsePerCell (source: [Source]) {
//
//        var allFollowing = [Following]()
//
//        for source in source {
//
//            //allFollowing.append(Following(source: source, news: []))
//
//            var follow : Following = Following(source: source, news: [])
//
//            for news in allNews {
//                if news.news.source.id == source.id {
//                    follow.news.append(news)
//                }
//            }
//
//            allFollowing.append(follow)
//
//        }
//
//        following = allFollowing
//        apiResponse?.success = true
//
//    }
    
    func topHeadlines (sources: [Source], language: String) {
        
        let parameters = [
            "sources" : Source.changeSourcesToString(sources: sources),
            "pageSize" : 100,
            "apiKey" : K.Keys.newsKey,
            "language" : language
        ] as [String : Any]
        
        let apiUtil = APINewsUtility(_parameters: parameters, url: K.URLs.topHeadings)
        
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
    
}

class APINewsUtility : ObservableObject {
    
    @Published var parameters = [String : Any]()
    
    @Published var url : String = ""
    
    
    @Published var news = [News]()
    
    
    init(_parameters: [String : Any], url: String) {
        self.parameters = _parameters
        self.url = url
    }
    
    func getNews (sources: [Source], completion: @escaping (NewsCompletion) -> Void) {

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { [self] response in
            
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
                            
                            //print(decodedData)
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
                            
                            news = allNews
                            //topHeadlines = allNews
                            
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

struct Following : Identifiable {
    let id = UUID()
    let source : Source
    var news : [News]
}

extension Following {
    
    static let sample : [Following] = [(Following(source: Source.sampleSources[0], news: [News.sampleNews[0]]))]
    
}
