//
//  News.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import Foundation

struct News : Identifiable {
    let id = UUID()
    var news : _Articles
    var category : CategoryTypes
    var iconURL : String
 
}

extension News {
    static let sampleNews : [News] = [News(news: _Articles(source: _Source(id: "bbc-news", name: "BBC News"), author: "BBC News", title: "No New covid rules in England before new year - Javid", description: "The health secretary says people should remain cautious, but that no new measures are needed now.", url: "http://www.bbc.co.uk/news/uk-59804686", urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/13557/production/_122519197_gettyimages-1237400050.jpg", publishedAt: "2021-12-27T16:52:17.3567708Z", content: "Image source, Getty Images\r\nThere will be no further Covid restrictions in England before the new year, Sajid Javid has said.\r\nBut the health secretary said people should \"remain cautious\" and celebr… "), category: .general, iconURL: "www.bbc.com")]
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
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
}

struct _Source : Codable {
    var id : String?
    var name : String
}
