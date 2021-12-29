//
//  RootView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var selectedTab : TabSelectors = .home
    
    var body: some View {
//
//        NavigationView {
            
            ZStack {
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                
            NewsLandingScreen()
                    .opacity(selectedTab == .home ? 1 : 0)
                
                DiscoverLandingScreen()
                    .opacity(selectedTab == .search ? 1 : 0)
                
                Text("Bookmark")
                    .opacity(selectedTab == .bookmark ? 1 : 0)
                
                Text("Profile")
                    .opacity(selectedTab == .person ? 1 : 0)
               
//                if selectedTab == .home {
//                    NewsLandingScreen()
//                } else if selectedTab == .search {
//                    Text("Search")
//                } else if selectedTab == .bookmark {
//                    Text("Bookmark")
//                } else {
//                    Text("Profile")
//                }
                
                VStack {
                    Spacer()
                    CustomTabBar(selection: $selectedTab)
                }
                //.background(Color.whiteBlueDark)
                .edgesIgnoringSafeArea(.bottom)
            
            }
            .environmentObject(userProfile)
            
        //}
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(UserProfile())
    }
}
