//
//  CodeVerificationScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct CodeVerificationScreen: View {
    
    @ObservedObject var viewModel = ResetPasswordViewModel()
    
    
    var body: some View {
        ZStack {
            
            Color.cWhite
            
            VStack  {
                
                NavigationHeader()
                
                if !viewModel.emailSent {
                    VerificationStack(viewModel: viewModel)
                } else {
                    UpdatePasswordStack(viewModel: viewModel)
                }
                Spacer()
                            
            }
            .padding()
        }
        .hideNavigationBar()
    }
}

struct CodeVerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerificationScreen()
    }
}




