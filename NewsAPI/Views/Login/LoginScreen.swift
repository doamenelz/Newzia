//
//  LoginScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var onSignIn : Bool = false
    @State private var email : String = ""
    
    @StateObject var signInViewModel = SignInViewModel()
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
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
        .environmentObject(userProfile)
        .hideNavigationBar()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}


