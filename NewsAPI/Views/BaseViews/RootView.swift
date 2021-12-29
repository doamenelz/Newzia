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
                //Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                
            //NewsLandingScreen()
              Text("Home")
                    //.zIndex(selectedTab == .home ? 2 : 1)
                    .opacity(selectedTab == .home ? 1 : 0)
                
                DiscoverLandingScreen()
                    //.zIndex(selectedTab == .search ? 2 : 1)
                    .opacity(selectedTab == .search ? 1 : 0)
                
                Text("Bookmark")
                    .opacity(selectedTab == .bookmark ? 1 : 0)
                
                Text("Profile")
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
