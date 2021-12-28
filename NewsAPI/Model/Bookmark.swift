//
//  Bookmark.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import Foundation

struct BookMark : Identifiable {
    let id = UUID()
    let bookMarkID : String
    let news : News
}

struct BookMarks : Identifiable {
    let id = UUID()
    let name : String
    let news : [News]
}
