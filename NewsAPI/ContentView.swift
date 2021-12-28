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
        ProductTourScreen()
            .environmentObject(userProfile)
            .onAppear(perform: {
                
            })
//            .onAppear(perform: {
//
//                apiUtility.getTopHeadlines(sources: [Source(id: "bbc-news", name: "BBC News", description: "Description", url: "www.bbc.com", category: "General", language: "en", country: "gb")])
//
//
//
//            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
