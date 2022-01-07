//
//  BookmarkViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-06.
//

import Foundation

class BookmarkViewModel : ObservableObject {
    
    @Published var bookmarkedNewsItems = News.getBookmarkFromUD()
    
    @Published var selectedNews : News?
    
    
}
