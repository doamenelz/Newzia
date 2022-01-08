//
//  ProfileSettingsCell.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-08.
//

import Foundation
import SwiftUI

struct ProfileSettingsCell: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var label : String
    var icon : SystemIcons
    var type : SettingsCellType
    
    
    func convertSort () -> String {
        switch userProfile.sortParameter {
            case NewsSortType.popularity.rawValue:
                return "By Popularity"
            case NewsSortType.relevancy.rawValue:
                return "By Relevancy"
            case NewsSortType.publishedDate.rawValue:
                return "By Date"
            
            default:
                return "By Date"
                
            
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon.rawValue)
            Text(label)
                .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
            
            Spacer()
            
            if (type == .sources) || (type == .categories) {
                Image(systemName: SystemIcons.chevronRight.rawValue)
                    .font(.caption)
            }
            
            if type == .newsFeed {
                Text(convertSort())
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                    .opacity(0.8)
                Image(systemName: SystemIcons.chevronRight.rawValue)
                    .font(.caption)
                
            }
            
            if type == .country {
                Image(userProfile.country.code.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            
            if type == .language {
                Text(userProfile.language.uppercased())
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                    .opacity(0.8)
            }
            
        }
        .padding()
        .contentShape(Rectangle())
        Divider()
            
    }
}
