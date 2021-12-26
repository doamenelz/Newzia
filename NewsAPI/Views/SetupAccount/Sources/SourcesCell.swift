//
//  SourcesCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SourcesCell: View {
    
    var source : Source
    
    var isSelected : Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Image(systemName: isSelected ? SystemIcons.selectedCheckbox.rawValue : SystemIcons.deselectedCheckbox.rawValue)
                    .foregroundColor(isSelected ? .cRed : .cGreyMedium)
                    .background(isSelected ? .clear : .cGreyMedium)
                    .cornerRadius(5)
                
            }
            Spacer()
            WebImage(url: URL(string: K.URLs.clearBit + source.url), isAnimating: .constant(false))
                .resizable()
                .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                .foregroundColor(.cBlueMedium)
                .background(Color.cWhite)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
            
            Text(source.name)
                .modifier(FontModifier(color: .cBlueDark, size: .body, type: .bold))
            
            Spacer()
        }
        .padding()
        .frame(width: K.Dimensions.frameWidth / 2.5, height: K.Dimensions.frameHeight / 4.5)
        .background(Color.cGrey)
        
        .cornerRadius(30)
        
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous) .strokeBorder(lineWidth: 5).foregroundColor(isSelected ? .cRed : .clear))
        .padding(.vertical, 10)
        
    }
}

struct SourcesCell_Previews: PreviewProvider {
    static var previews: some View {
        SourcesCell(source: Source(id: "", name: "International News Services", description: "description", url: "https://www.google.com", category: "general", language: "en", country: "us"), isSelected: true)
    }
}
