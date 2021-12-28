//
//  APIUtility.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import Foundation
import Combine
import Alamofire

class APIUtility : ObservableObject {
    
    func changeSourcesToString (sources: [Source]) -> String {
        
        var concatenated : [String] = []
        
        for source in sources {
            concatenated.append(source.id)
        }
        
        print(concatenated)
        return concatenated.joined(separator: ",")
    }
    
    func getTopHeadlines (sources: [Source]) {
        
        let parameters = [
            "sources" : changeSourcesToString(sources: sources),
            "pageSize" : 30,
            "apiKey" : K.Keys.newsKey
        ] as [String : Any]
        
        AF.request(K.URLs.topHeadings, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { [self] response in
            
            switch response.result {
                    
                case .success(_):
                    print("Successfully called the TopHeadlines ")
                    guard let data = response.data else {return}
                    
                    if response.response?.statusCode == 200 {
                        print("Calling parseNews")
                        parseNews(jsonData: data, sources: sources)
                        
                    } else {
                        
                    }
                    
                case .failure(_):
                    print("Failed the topHeadlines")
            }
            
            
            
        }
            
        
        
    }
    
    func parseNews (jsonData: Data, sources: [Source]) {
        
        var allNews = [News]()
        
        do {
            let decodedData = try JSONDecoder().decode(_News.self,
                                                       from: jsonData)
            
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
            
            print(allNews)
            
            
        } catch {
            print(error)
        }
        
    }
    
}

struct NewsResponse {
    
    let news : News?
    let error : ErrorModel?
    
    
    
}

struct _News : Codable {
    var totalResults : Int
    var articles : [_Articles]
}

struct _Articles : Codable {
    var source : _Source
    var author : String?
    var title : String
    var description : String
    var url : String
    var urlToImage : String
    var publishedAt : String
    var content : String?
}

struct _Source : Codable {
    var id : String?
    var name : String
}


