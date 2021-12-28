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
        
        NavigationView {
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                if selectedTab == .home {
                    NewsLandingScreen()
                } else if selectedTab == .search {
                    Text("Search")
                } else if selectedTab == .bookmark {
                    Text("Bookmark")
                } else {
                    Text("Profile")
                }
                
                
                
                VStack {
                    Spacer()
                    CustomTabBar(selection: $selectedTab)
                }
                //.background(Color.whiteBlueDark)
                .edgesIgnoringSafeArea(.bottom)
            
            }
            .environmentObject(userProfile)
            
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(UserProfile())
    }
}
