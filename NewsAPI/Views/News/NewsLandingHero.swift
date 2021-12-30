//
//  NewsLandingHero.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsLandingHero: View {
    
    var news : News
    
    var small : Bool
    
    var body: some View {
        
        ZStack {
            
            WebImage(url: URL(string: news.news.urlToImage ?? ""))
                .resizable()
                .placeholder(Image(AppAssets.SplashScreen.icon))
                .aspectRatio(contentMode: .fill)
                .transition(.fade(duration: 0.5))
                .frame(width: K.Dimensions.frameWidth - 40, height: small ? K.Dimensions.frameHeight / 3 : K.Dimensions.frameHeight / 2)
            
            
            VStack (alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    Image(systemName: SystemIcons.bookmark.rawValue)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 40, height: 40)
                        .background(Color.cRed)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                HStack {
                    Text(news.category.rawValue)
                        .modifier(FontModifier(color: .white, size: .label, type: .medium))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color.cBlueMedium)
                        .cornerRadius(20)
                    Spacer()
                }
                
                Text(news.news.title ?? "")
                    .modifier(FontModifier(color: .white, size: .large, type: .bold))
                
                HStack {
                    WebImage(url: URL(string: K.URLs.clearBit + news.iconURL))
                        .resizable()
                        .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                        .foregroundColor(.cBlueMedium)
                        .background(Color.cWhite)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                    Text(news.news.source.name.uppercased())
                        .modifier(FontModifier(color: .white, size: .body, type: .bold))
                    
                    Spacer()
                    
                    Text("3 Hours ago")
                        .modifier(FontModifier(color: .white, size: .label, type: .regular))
                }
                
            }
            .padding()
            .padding(.bottom, 10)
            .modifier(HeroGradient())
            
            
        }
        .frame(height: small ? K.Dimensions.frameHeight / 3 : K.Dimensions.frameHeight / 2)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}


struct NewsLandingHero_Previews: PreviewProvider {
    static var previews: some View {
        NewsLandingHero(news: News.sampleNews[0], small: true)
    }
}
