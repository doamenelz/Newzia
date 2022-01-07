//
//  NewsWebView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct NewsWebView: View {
    
    @State var workState = WebView.WorkState.initial
    
    @EnvironmentObject var userProfile : UserProfile
    
    @Binding var dismiss : Bool
    
    var webLink : String
    
    var news : News?
    
    @State private var isBookmarked : Bool = false
    
    var body: some View {
        
        ZStack {
            
            VStack (spacing: 0) {
                
                HStack {
                    
                    Image(systemName: SystemIcons.xMark.rawValue)
                        .padding()
                        .onTapGesture {
                            dismiss.toggle()
                        }
                    
                    Spacer()
                    
                    if news != nil {
                        Image(systemName: SystemIcons.bookmark.rawValue)
                            .padding()
                            .foregroundColor(userProfile.bookmarks.contains(where: {$0.news.url == news!.news.url}) ?  .cRed :  .darkGreySoft)
                            .onTapGesture {
                                print(userProfile.bookmarks)
                                bookmarkTapped()
                            }
                    }
                    
                    
                    Link(destination: URL(string: webLink)!) {
                        Image(systemName: "link.circle.fill")
                            .foregroundColor(.darkGreySoft)
                            .padding()
                    }
                    
                    
                }
                .font(.title3)
                .background(Color.whiteBlueDark)
                
                WebView(urlString: webLink, workState: $workState)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            if workState != .done {
                CircularLoad()
                    
            }
            
        }
    }
}

struct NewsWebView_Previews: PreviewProvider {
    static var previews: some View {
        NewsWebView(dismiss: .constant(false), webLink: "https://www.apple.com", news: News.sampleNews[0]).preferredColorScheme(.dark).environmentObject(UserProfile())
    }
}

extension NewsWebView {
    
    func transposeToCodable (completion: @escaping ([_NewsCodable]) -> Void) {
        
        var _news = [_NewsCodable]()
        
        for item in userProfile.bookmarks {
            let _item = _NewsCodable(news: item.news, category: item.category.rawValue, iconURL: item.iconURL)
            _news.append(_item)
        }
        
        //print(_news)
        completion(_news)
        
        
    }
    
    func bookmarkTapped () {
        
        if userProfile.bookmarks.contains(where: {$0.news.url == news!.news.url}) {
            
            userProfile.bookmarks.removeAll(where: {$0.news.url == news!.news.url})
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                News.saveAsBookmark(news: userProfile.bookmarks)
                
            }
            
            
        } else {
            
            userProfile.bookmarks.append(news!)
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                News.saveAsBookmark(news: userProfile.bookmarks)
            }
            
        }
        
    }
    
}
