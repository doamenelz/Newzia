//
//  SetupCompleteScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI

struct SetupCompleteScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    @State private var goToRootView : Bool = false
    
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 60) {
                
                Text("You're all set!!")
                    .modifier(FontModifier(color: .darkGreySoft, size: .h1, type: .bold))
                    .padding(.top, 40)
                
                
                VStack (spacing: 10) {
                    Image(uiImage: userProfile.avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .modifier(ProfileAvatarModifier())
                    
                    Text(userProfile.name)
                        .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
                    Text("@\(userProfile.username)")
                        .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                }
                
                Spacer()
                
                
                Button(action: {
                    withAnimation {
                        goToRootView.toggle()
                    }
                    
                }, label: {
                    CTARed(label: "Home")
                })
                
            }
            .padding()
            
            if goToRootView {
                RootView()
            }
            
        }
        .environmentObject(userProfile)
    }
}

struct SetupCompleteScreen_Previews: PreviewProvider {
    static var previews: some View {
        SetupCompleteScreen()
    }
}
