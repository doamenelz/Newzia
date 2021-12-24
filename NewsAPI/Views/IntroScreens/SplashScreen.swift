//
//  SplashScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.cWhite
            VStack {
                Spacer()
                Image(AppAssets.SplashScreen.icon)
                Spacer()
                HStack {
                    Image(AppAssets.SplashScreen.corner)
                        
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
