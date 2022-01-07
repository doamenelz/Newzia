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
    
    @StateObject var appDataModel = AppDataModel()
   
    
    var body: some View {
        
        if userProfile.isSignedIn {
            RootView()
            //DiscoverLandingScreen()
                .environmentObject(userProfile)
                .onAppear(perform: {
                    print(UserDefaults.standard.dictionaryRepresentation())
                })
        } else {
            ProductTourScreen()
            //DiscoverLandingScreen()
                .environmentObject(userProfile)
                .onAppear(perform: {
                    //print(UserDefaults.standard.dictionaryRepresentation())
                })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


