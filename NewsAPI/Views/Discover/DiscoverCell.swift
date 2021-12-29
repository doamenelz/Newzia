//
//  DiscoverCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct DiscoverCell: View {
    
    var label : String
    var image : String
    var countLabel : String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                //.clipped()
                .aspectRatio(contentMode: .fill)
                
                .frame(height: K.Dimensions.frameHeight / 6)
                .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
            
            VStack (alignment: .leading, spacing: 5) {
                Spacer()
                HStack {
                    Text(label)
                        .modifier(FontModifier(color: .white, size: .body, type: .bold))
                    Spacer()
                }
                Text(countLabel)
                    .modifier(FontModifier(color: .white, size: .label, type: .light))
            }
            .padding()
            .modifier(DiscoverGradient())
        }
        .frame(height: K.Dimensions.frameHeight / 6)
        .modifier(DiscoverGradient())
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct DiscoverCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCell(label: "Categories you follow", image: AppAssets.SplashScreen.productTour1, countLabel: "5 Items")
    }
}

struct DiscoverCellCountry: View {
    
    var label : String
    //var news : [News]
    var image : String
    var country : String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                //.clipped()
                //.aspectRatio(contentMode: .fill)
                .frame(height: K.Dimensions.frameHeight / 6)
                .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            VStack (alignment: .leading, spacing: 5) {
                Spacer()
                Image(country)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 24)
                HStack {
                    Text(label)
                        .modifier(FontModifier(color: .white, size: .body, type: .bold))
                        
                    
                        
                    Spacer()
                }
                
                
                
                //Text("\(news.count) Items")
                  //  .modifier(FontModifier(color: .white, size: .label, type: .medium))
            }
            .padding()
            .modifier(DiscoverGradient())
        }
        .frame(height: K.Dimensions.frameHeight / 6)
        //.modifier(DiscoverGradient())
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

enum DiscoverTypes {
    case categories
    case topics
    case country
    case sources
}
