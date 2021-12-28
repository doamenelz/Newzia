//
//  GuestOverlayScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-26.
//

import SwiftUI

struct GuestOverlayScreen: View {
    var body: some View {
        VStack  {
            
            HStack {
                Spacer()
                
                Image(systemName: SystemIcons.xMark.rawValue)
                
            }
            .padding()
            
            VStack (spacing: 20) {
                Text("Continue as a Guest")
                    .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                
                Text("You can still explore the app and create an account later, but you will get only default features of this app until then")
                
                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .regular))
                    .lineSpacing(5)
                    .multilineTextAlignment(.center)
                
                CTARed(label: "Confirm")
                    .frame(width: K.Dimensions.frameWidth / 2)
            }
            .padding([.horizontal, .bottom])
            
            
        }
        .padding()
        .background(Color.whiteBlueDark)
        .cornerRadius(40)
        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
    }
}

struct GuestOverlayScreen_Previews: PreviewProvider {
    static var previews: some View {
        GuestOverlayScreen()
    }
}
