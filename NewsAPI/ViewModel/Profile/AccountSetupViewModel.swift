//
//  AccountSetupViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import Combine

class AccountSetupViewModel : ObservableObject {
    
    @Published var selectedCountry : Country?
    
    @Published var selectedCategories : [Category] = []
    
    
}
