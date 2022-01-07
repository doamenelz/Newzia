//
//  NewsCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsCell: View {
    
    var news : News
    
    var body: some View {
        
        HStack {
            WebImage(url: URL(string: news.news.urlToImage ?? ""))
                .resizable()
                .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                .aspectRatio(contentMode: .fill)
                .transition(.fade(duration: 0.5))
                .frame(width: 80, height: 92)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(news.news.source.name)")
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                Text(news.news.title ?? "")
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .bold))
                Text(DateHelpers.formatToString(date: news.news.publishedAt ?? ""))
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .light))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.greyLBlueMedDark)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(news: News.sampleNews[0]).fixedSize()
    }
}
