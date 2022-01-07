//
//  BookmarksLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-06.
//

import SwiftUI

struct BookmarksLandingScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject var viewModel = BookmarkViewModel()
    
    @State private var openURLView : Bool = false
    
    @State private var searchedText : String = ""
    
    var body: some View {
        
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    VStack (alignment: .leading, spacing: 2) {
                        Text("Bookmarks")
                            .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                        Text("\(userProfile.bookmarks.count) Saved Items")
                            .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                    }
                    Spacer()
                    
                    
                }
                
                IconTextField(icon: .search, placeHolder: "Search", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false)
                
                ScrollView {
                    
                    NewsListItems(allNews: searchedText == "" ? userProfile.bookmarks : userProfile.bookmarks.filter({$0.news.source.name.uppercased().contains(searchedText.uppercased()) || $0.category.rawValue.uppercased().contains(searchedText.uppercased()) || $0.news.title!.uppercased().contains(searchedText.uppercased())}), selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: false)
                        //.padding()
                        .sheet(isPresented: $openURLView, onDismiss: {
                            
                        }, content: {
                            NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com", news: viewModel.selectedNews)
                            
                        })
                }
                
            }
            .padding()
            
        }
        
    }
    
}

struct BookmarksLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksLandingScreen().environmentObject(UserProfile())
    }
}
