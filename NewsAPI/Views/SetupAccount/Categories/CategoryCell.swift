//
//  CategoryCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI

struct CategoryCell: View {
    
    var category : Category
    
    var isSelected : Bool
    
    
    var body: some View {
        ZStack {
            Image(category.type.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: K.Dimensions.frameWidth / 2.3, height: K.Dimensions.frameHeight / 4)
           
            VStack {
                
                    HStack {
                        Spacer()
                        Image(systemName: isSelected ? SystemIcons.selectedCheckbox.rawValue : SystemIcons.deselectedCheckbox.rawValue)
                            .foregroundColor(isSelected ? .cRed : .cGrey)
                            .background(isSelected ? .clear : .cGrey)
                            .cornerRadius(5)
                        
                    }.padding()
                    
                    
                
                Spacer()
                
                HStack {
                    Text(category.type.rawValue)
                        .modifier(FontModifier(color: .cWhite, size: .body, type: .bold))
                    Spacer()
                }
                .padding()
                
                
            }
            .modifier(BottomGradient())
        }
        .frame(width: K.Dimensions.frameWidth / 2.3, height: K.Dimensions.frameHeight / 4)
        //.cornerRadius(30)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous) .strokeBorder(lineWidth: 5).foregroundColor(isSelected ? .cRed : .clear))
        //.padding(.vertical, 10)
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(category: Category.categories[0], isSelected: false)
    }
}
