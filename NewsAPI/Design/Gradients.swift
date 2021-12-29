//
//  Gradients.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import Foundation
import SwiftUI

struct TopGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.cGrey, Color.black.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct BottomGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.1), Color.black]), startPoint: .top, endPoint: .bottom))
    }
}

struct HeroGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black]), startPoint: .top, endPoint: .bottom))
    }
}

