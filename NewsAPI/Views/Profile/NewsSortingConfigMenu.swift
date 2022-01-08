//
//  NewsSortingConfigMenu.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-08.
//

import Foundation
import SwiftUI

struct NewsSortConfigurationScreen : View {
    
    @Binding var dismiss : Bool
    
    @EnvironmentObject var userProfile : UserProfile
    
    var body: some View {
        
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationHeader()
                
                HStack {
                    Text("Sort your news articles By")
                        .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .medium))
                    Spacer()
                }
                .padding(.bottom, 10)
                
                NewsSortSettingsCell(isSelected: userProfile.sortParameter.uppercased().contains(NewsSortType.publishedDate.rawValue.uppercased()), type: .publishedDate)
                    .onTapGesture {
                        userProfile.sortParameter = NewsSortType.publishedDate.rawValue
                        
                        dismiss.toggle()
                    }
                
                NewsSortSettingsCell(isSelected: userProfile.sortParameter.uppercased().contains(NewsSortType.relevancy.rawValue.uppercased()), type: .relevancy)
                    .onTapGesture {
                        userProfile.sortParameter = NewsSortType.relevancy.rawValue
                        dismiss.toggle()
                    }
                
                NewsSortSettingsCell(isSelected: userProfile.sortParameter.uppercased().contains(NewsSortType.popularity.rawValue.uppercased()), type: .popularity)
                    .onTapGesture {
                        userProfile.sortParameter = NewsSortType.popularity.rawValue
                        dismiss.toggle()
                    }
                
                Spacer()
                
                
                
            }
            .padding()
            
        }
        
    }
}

struct NewsSortSettingsCell: View {
    
    var isSelected : Bool
    
    var type : NewsSortType
    
    
    
    var body: some View {
        
        var textInfo : (label: String, description: String) {
            get {
                switch type {
                    case .popularity:
                        return (label: "Popularity", description: "Articles from popular sources will come first")
                    case .relevancy:
                        return (label: "Relevancy", description: "Articles closely related to the Category or searched values will come first")
                    case .publishedDate:
                        return (label: "Published Date", description: "Recently published articles will come first")
                }
            }
        }
        
        return HStack {
            VStack (alignment: .leading, spacing: 10) {
                Text(textInfo.label)
                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
                Text(textInfo.description)
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
            }
            
            Spacer()
            
            if isSelected {
                Image(systemName: SystemIcons.selectedCheckbox.rawValue)
                    .foregroundColor(.cRed)
            }
            
        }
        .padding()
        .background(isSelected ? Color.greyBlueMedDark : Color.clear)
        .cornerRadius(15)
        .contentShape(Rectangle())
    }
}
