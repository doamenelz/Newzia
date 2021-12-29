//
//  DiscoverLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct DiscoverLandingScreen: View {
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack (spacing: 20) {
                    DiscoverLandingHeader()
                    
                    DiscoverCell(label: "Categories you follow", image: AppAssets.SplashScreen.productTour1, countLabel: "5 Categories")
                    
                    DiscoverCell(label: "Sources you follow", image: AppAssets.SplashScreen.productTour2, countLabel: "3 Sources")
                    
                    DiscoverCell(label: "#Topics you follow", image: AppAssets.SplashScreen.productTour3, countLabel: "17 Topics")
                    
                    DiscoverCellCountry(label: "United States", news: News.sampleNews, image: AppAssets.SplashScreen.productTour1, country: "us")
                    
                    
                    
                }
                .padding()
            }
        }
    }
}

struct DiscoverLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverLandingScreen().preferredColorScheme(.dark)
    }
}


struct DiscoverGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    }
}





//MARK: - Internal Components -

fileprivate struct DiscoverLandingHeader: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 2) {
                Text("Discover")
                    .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                Text("Recent news from")
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
            }
            Spacer()
            
            Image(systemName: SystemIcons.search.rawValue)
                .padding()
            //.font(.title2)
            
            
        }
    }
}
