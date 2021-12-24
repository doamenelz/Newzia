//
//  SignUpViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import Combine

class SignUpViewModel : ObservableObject {
    
    @Published var name : String = ""
    
    @Published var email : String = ""
    
    @Published var password : String = ""
    
    @Published var agreedToTerms : Bool = false
    
}
