//
//  Buttons.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        //CTA(label: "CTA Label")
        CTAwIcon(label: "Cibtubye", icon: .google, primary: false)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct CTA: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .modifier(FontModifier(color: .white, size: .body, type: .regular))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.redBlueMedium)
            .cornerRadius(K.Dimensions.buttonCornerRadius)
    }
}


struct CTARed: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .modifier(FontModifier(color: .white, size: .body, type: .regular))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.cRed)
            .cornerRadius(K.Dimensions.buttonCornerRadius)
    }
}


struct CTAwIcon: View {
    
    var label : String
    var icon : CustomIcons
    var primary : Bool
    
    var body: some View {
        HStack {
            Image(icon.rawValue)
                .resizable()
                .frame(width: 18, height: 18)
            Text(label)
                .modifier(FontModifier(color: primary ? .cWhite : .cBlueDark, size: .body, type: .regular))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(primary ? Color.cRed : Color.greyBlueMedium)
        .cornerRadius(K.Dimensions.buttonCornerRadius)
    }
}


struct SmallButton: View {
    var label : String
    var isSelected : Bool
    
    var body: some View {
        Text(label)
            .modifier(FontModifier(color: isSelected ? .cWhite : .darkGreySoft, size: .body, type: .medium))
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(isSelected ? Color.blueRed : Color.clear)
            .cornerRadius(26)
    }
}
