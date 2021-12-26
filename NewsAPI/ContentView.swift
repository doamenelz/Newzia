//
//  ContentView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userProfile = UserProfile()
    
    var body: some View {
        ProductTourScreen()
            .environmentObject(userProfile)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
