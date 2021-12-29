//
//  DiscoverSourcesCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct DiscoverSourcesCell: View {
    
    var source : Source
    
    var body: some View {
        HStack (spacing: 15) {
            
            WebImage(url: URL(string: K.URLs.clearBit + source.url))
                .resizable()
                .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            
            VStack (alignment: .leading, spacing: 5) {
                Text(source.name)
                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .bold))
                //Text("\(source.news.count) Item\(source.news.count != 1 ? "s" : "")")
                Text(source.category.capitalized)
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
            }
            
            Spacer()
            
            Image(systemName: SystemIcons.chevronRight.rawValue)
                .font(.caption)
            //.padding(.trailing)
        }
    }
}

struct DiscoverSourcesCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverSourcesCell(source: Source.sampleSources[0])
    }
}
