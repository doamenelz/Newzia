//
//  LoginScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var onSignIn : Bool = false
    @State private var email : String = ""
    
    @StateObject var signInViewModel = SignInViewModel()
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            Color.cWhite
            VStack {
                NavigationHeader()
                
                HStack {
                    SmallButton(label: "Sign In", isSelected: onSignIn)
                        .onTapGesture {
                                onSignIn = true
                        }
                    SmallButton(label: "Sign Up", isSelected: !onSignIn)
                        .onTapGesture {
                                onSignIn = false
                        }
                    Spacer()
                }
                .padding(.bottom)
                
                if onSignIn {
                    
                    SignInStack(viewModel: signInViewModel)
                    
                } else {
                    
                    SignUpStack(viewModel: signUpViewModel)
                    
                }
                
                
                
               
                
            }
            .padding()
        }
        .hideNavigationBar()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}


