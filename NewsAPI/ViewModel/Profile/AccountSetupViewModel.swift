//
//  AccountSetupViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import Combine
import UIKit
import SwiftUI


//TODO: Sort Sources List by selected Country

class AccountSetupViewModel : ObservableObject {
    
    @Published var selectedCountry : Country?
    
    @Published var selectedCategories : [Category] = []
    
    @Published var selectedSources : [Source] = []
    
    @Published var username : String = ""
    
    @Published var avatar : UIImage?
    
    @Published var name : String = "Edem Ekeng"
    
    @Published var persistCompleted : Bool = false
    
    func persistUserProfile () {
        
        
        
        
        
    }
    
}



