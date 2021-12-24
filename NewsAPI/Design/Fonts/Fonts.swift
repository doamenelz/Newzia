//
//  Fonts.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import Foundation
import SwiftUI

enum CustomFonts : String {
    case thin = "Montserrat-Thin"
    case extraLight = "Montserrat-ExtraLight"
    case light = "Montserrat-Light"
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case bold = "Montserrat-Bold"
    case extraBold = "Montserrat-SemiBold"
    case black = "Montserrat-Black"
    
    }


enum FontSizes : CGFloat {
    case label = 12
    case body = 14
    case large = 18
    case h1 = 35
}

struct FontModifier : ViewModifier {
    var color : Color
    var size : FontSizes
    var type : CustomFonts
    func body(content: Content) -> some View {
        content
            .font(.custom(type.rawValue, size: size.rawValue) )
            .foregroundColor(color)
    }
}
