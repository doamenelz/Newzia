//
//  SignInStack.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//


//TODO: Remove first letter capitalizing in email
//TODO: Implement regex for email

import SwiftUI

struct SignInStack: View {
    
    @ObservedObject var viewModel : SignInViewModel
    @State private var checkEntry : Bool = false
    
    @State private var goToNext : Bool = false
    @State private var forgotPasswordToggled : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text("Let's Sign")
                    Text("You In")
                }
                .modifier(FontModifier(color: .cBlueDark, size: .h1, type: .bold))
                
                Spacer()
            }
            
            VStack (alignment: .leading, spacing: 20) {
                IconTextField(icon: .mail, placeHolder: "Email", text: $viewModel.email, isMandatory: true, errorMessage: "Please enter a valid email", checkEntry: checkEntry)
                
                IconTextFieldPassword(icon: .lock, placeHolder: "Password", text: $viewModel.password, isMandatory: true, errorMessage: "Please enter a value", checkEntry: checkEntry)
                
                Text("Forgot Password?")
                    .modifier(FontModifier(color: .cBlueMedium, size: .body, type: .medium))
                    .padding(.vertical)
                    .onTapGesture {
                        forgotPasswordToggled.toggle()
                    }
            }
            
            
            
            Spacer()
            
            Button(action: {
                
                if !checkEntry {
                    checkEntry.toggle()
                }
                
            }, label: {
                CTA(label: "Sign In")
            })
            
            
            Text("Or sign in with")
                .padding()
                .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
            HStack {
                Button(action: {
                    
                }, label: {
                    CTAwIcon(label: "Google", icon: .google, primary: false)
                })
                
                Button(action: {
                    
                }, label: {
                    CTAwIcon(label: "Apple", icon: .apple, primary: false)
                })
            }
            
            
            NavigationLink(isActive: $forgotPasswordToggled, destination: {
                ForgotPasswordScreen()
            }, label: {
                EmptyView()
            })
            
            
        }
    }
}

struct SignInStack_Previews: PreviewProvider {
    static var previews: some View {
        SignInStack(viewModel: SignInViewModel())
    }
}
