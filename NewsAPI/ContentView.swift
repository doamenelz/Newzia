//
//  ContentView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userProfile = UserProfile()
    
    @StateObject var appDataModel = AppDataModel()
   
    
    var body: some View {
        
        if userProfile.isSignedIn {
            RootView()
                .environmentObject(userProfile)
                .onAppear(perform: {
                    print(UserDefaults.standard.dictionaryRepresentation())
                })
        } else {
            ProductTourScreen()
                .environmentObject(userProfile)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


