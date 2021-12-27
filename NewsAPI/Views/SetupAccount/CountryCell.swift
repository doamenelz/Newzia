//
//  CountryCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-26.
//

import SwiftUI

struct CountryCell: View {
    var country : Country
    
    var isSelected : Bool
    
    var body: some View {
        
        HStack (alignment: .center) {
            Image(country.code.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .cornerRadius(3)
            
            Text(country.code)
                .modifier(FontModifier(color: isSelected ? .cGreyMedium : .cBlueDark, size: .label, type: .light))
            Text(country.name)
                .modifier(FontModifier(color: isSelected ? .cWhite : .cBlueDark, size: .body, type: .medium))
            
            Spacer()
            
            Image(systemName: isSelected ? SystemIcons.selectedCheckbox.rawValue : SystemIcons.deselectedCheckbox.rawValue)
                .foregroundColor(isSelected ? .redWhite : .clear)
 
        }
        .padding()
        .background(isSelected ? Color.blueRed : .clear)
        .cornerRadius(17)
    }
}

struct CountryCell_Previews: PreviewProvider {
    static var previews: some View {
        CountryCell(country: Country(name: "am", code: "us"), isSelected: false)
    }
}
