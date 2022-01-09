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
        NavigationView {
            
            ZStack {
                NewsLandingScreen()
                    .opacity(selectedTab == .home ? 1 : 0)
                
                DiscoverLandingScreen()
                    .opacity(selectedTab == .search ? 1 : 0)
                
                BookmarksLandingScreen()
                    .opacity(selectedTab == .bookmark ? 1 : 0)
                
                ProfileLanding()
                    .opacity(selectedTab == .person ? 1 : 0)
                
                VStack {
                    Spacer()
                    CustomTabBar(selection: $selectedTab)
                }
                .edgesIgnoringSafeArea(.bottom)
            
            }
            .hideNavigationBar()
            .environmentObject(userProfile)
            
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(UserProfile())
    }
}
