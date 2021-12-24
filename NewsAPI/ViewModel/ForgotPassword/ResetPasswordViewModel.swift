//
//  ResetPasswordViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import Foundation
import Combine

class ResetPasswordViewModel : ObservableObject {
    
    @Published var verificationPasscode : String = ""
    
    @Published var newPassword : String = ""
    
    @Published var repeatPassword : String = ""
    
    @Published var emailSent : Bool = false
    
    func sendEmail () {
        emailSent = true
    }
    
    
}
