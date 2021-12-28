//
//  UserProfile.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import Foundation
import Combine
import SwiftUI

class UserProfile : ObservableObject {
    
    @Published var name : String = ""
    @Published var country : Country?
    @Published var categories : [Category] = []
    @Published var sources : [Source] = []
    @Published var username : String = ""
    @Published var avatar = UIImage()
    @Published var email : String = ""
    
    @Published var isSignedIn : Bool = false
    
    func setUserProfile (categories: [Category], sources: [Source], avatar: UIImage, username: String, country: Country) {
        self.categories = categories
        self.sources = sources
        self.avatar = avatar
        self.username = username
        self.country = country
        
    }
    
}


    
    
    

