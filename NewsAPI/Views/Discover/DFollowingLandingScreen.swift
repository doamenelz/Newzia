//
//  DFollowingLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct DFollowingLandingScreen: View {
    
    @State private var searchedText : String = ""
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading){
                NavigationHeader()
                    .padding(.horizontal)
                
                VStack (alignment: .leading) {
                    Text("Sources")
                        .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                    Text("150 Following")
                        .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                IconTextField(icon: .search, placeHolder: "Search for sources", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false).padding(.horizontal)
                
                ScrollView {
                    
                    VStack (spacing: 20) {
                        
                        DSourcesCell(source: Source(id: "bbc-news", name: "BBC News", description: "Random Description", url: "www.bbc.com", category: "general", language: "en", country: "gb"))
                        
                    }
                    .padding()
                }
                
                
                                
            }
        }
    }
}

struct DFollowingLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DFollowingLandingScreen().preferredColorScheme(.dark)
    }
}

struct DSourcesCell: View {
    
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
                Text("10 Items")
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
            }
            
            Spacer()
            
            Image(systemName: SystemIcons.chevronRight.rawValue)
                .font(.caption)
            //.padding(.trailing)
        }
    }
}
