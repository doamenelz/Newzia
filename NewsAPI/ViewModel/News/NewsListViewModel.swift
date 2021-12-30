//
//  NewsListViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import Foundation

class NewsListViewModel : ObservableObject {
    
    @Published var allNews = [News]()
    
    @Published var selectedNews : News?
    
    
    
}
