//
//  Constants.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import Foundation
import SwiftUI

struct K {
    
    struct Dimensions {
        static let frameWidth = UIScreen.main.bounds.width
        static let frameHeight = UIScreen.main.bounds.height
        static let buttonCornerRadius : CGFloat = 18
        static let buttonHeight : CGFloat = 48
    }

    struct URLs {
        static let clearBit : String = "https://logo.clearbit.com/"
        static let BASE_NEWS : String = "https://newsapi.org/v2/"
        static let topHeadings : String = BASE_NEWS + "top-headlines"
        static let everything : String = BASE_NEWS + "everything"
    }
    
    struct Keys {
        static let newsKey = "7a87b85e39494218b36d2d2930a36988"
    }
    

    
}

var allAppSources = [Source]()

