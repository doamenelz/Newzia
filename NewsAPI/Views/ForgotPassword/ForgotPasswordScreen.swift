//
//  ForgotPasswordScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    
    @State private var checkEntry : Bool = false
    
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    @State private var goToNext : Bool = false
    
    
    var body: some View {
        ZStack {
            Color.cWhite
            VStack (alignment: .leading, spacing: 20) {
                NavigationHeader()
                
                HStack {
                    Spacer()
                    Image(AppAssets.ForgotPassword.forgotPassword)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: K.Dimensions.frameWidth / 1.5)
                    Spacer()
                }
                .padding(.bottom, 25)
                    
                
                VStack  (alignment: .leading, spacing: 20){
                    VStack (alignment: .leading) {
                        Text("Forgot")
                        Text("Password")
                    }
                    .modifier(FontModifier(color: .cBlueDark, size: .h1, type: .bold))
                    
                    Text("Enter your email address to reset your password")
                        .modifier(FontModifier(color: .cBlueMedium, size: .body, type: .medium))
                    
                    IconTextField(icon: .mail, placeHolder: "Email", text: $viewModel.email, isMandatory: true, errorMessage: "Enter a valid email", checkEntry: checkEntry)
                }
                
                Spacer()
                
                
                                Button(action: {
                    
                    if !checkEntry {
                        checkEntry.toggle()
                    }
                    
                    if viewModel.email != "" {
                        goToNext.toggle()
                    }
                    
                    
                }, label: {
                    CTA(label: "Next")
                })
                
                NavigationLink(isActive: $goToNext, destination: {
                    LoginScreen()
                }, label: {
                    EmptyView()
                })
            }
            .padding()
        }
        .hideNavigationBar()
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}
