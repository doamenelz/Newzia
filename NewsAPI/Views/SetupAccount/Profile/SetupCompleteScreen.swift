//
//  SetupCompleteScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI

struct SetupCompleteScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var body: some View {
        ZStack {
            Color.cWhite
            
            VStack (spacing: 60) {
                
                Text("You're all set!!")
                    .modifier(FontModifier(color: .cBlueDark, size: .h1, type: .bold))
                    .padding(.top, 40)
                
                
                VStack (spacing: 10) {
                    Image(uiImage: userProfile.avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .modifier(ProfileAvatarModifier())
                    
                    Text(userProfile.name)
                        .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
                    Text("@\(userProfile.username)")
                        .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
                }
                
                Spacer()
                
                
                Button(action: {
                    
                }, label: {
                    CTA(label: "Home")
                })
                
            }
            .padding()
        }
        .environmentObject(userProfile)
    }
}

struct SetupCompleteScreen_Previews: PreviewProvider {
    static var previews: some View {
        SetupCompleteScreen()
    }
}