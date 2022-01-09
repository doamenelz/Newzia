//
//  Following.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation
import Combine

struct Following : Identifiable {
    let id = UUID()
    let source : Source
    var news : [News]
}

extension Following {
    
    static let sample : [Following] = [(Following(source: Source.sampleSources[0], news: [News.sampleNews[0]]))]
    
}
