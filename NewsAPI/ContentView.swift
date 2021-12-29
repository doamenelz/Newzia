//
//  ContentView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct ContentView: View {
    
    //@StateObject var apiUtility = APIUtility()
    @ObservedObject var userProfile = UserProfile()
    
   
    
    var body: some View {
        //ProductTourScreen()
        DiscoverLandingScreen()
            .environmentObject(userProfile)
            .onAppear(perform: {
                
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
