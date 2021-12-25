//
//  Category.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import SwiftUI


struct Category : Identifiable {
    let id = UUID()
    let type : CategoryTypes
}

extension Category {
    static let categories : [Category] = [
        Category(type: .business),
        Category(type: .entertainment),
        Category(type: .general),
        Category(type: .health),
        Category(type: .science),
        Category(type: .sports),
        Category(type: .technology)
    ]
}


enum CategoryTypes : String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
}
