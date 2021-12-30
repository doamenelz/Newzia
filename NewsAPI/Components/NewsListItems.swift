//
//  NewsListItems.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import SwiftUI

struct NewsListItems: View {
    
    var allNews : [News]
    
    @Binding var selectedNews : News?
    
    @Binding var openURLView : Bool
    
    var hideFirst : Bool
    
    var body: some View {
        LazyVStack (spacing: 20) {
            
            ForEach(allNews) { news in
                
                if hideFirst {
                   
                    if news.id != allNews.first!.id {
                        
                        NewsCell(news: news)
                            .onTapGesture {
                                
                                DispatchQueue.main.async {
                                    selectedNews = news
                                }
                                
                                if news.news.url != "" {
                                    openURLView.toggle()
                                }
                                
                            }
                        
                        
                    }
                    
                    
                } else {
                    NewsCell(news: news)
                        .onTapGesture {
                            
                            DispatchQueue.main.async {
                                selectedNews = news
                            }
                            
                            if news.news.url != "" {
                                openURLView.toggle()
                            }
                            
                        }
                }
                
            }
            
            
        }
        .padding(.bottom, 60)
    }
    
}


struct NewsListItems_Previews: PreviewProvider {
    static var previews: some View {
        NewsListItems(allNews: News.sampleNews, selectedNews: .constant(News.sampleNews[0]), openURLView: .constant(false), hideFirst: false)
    }
}
