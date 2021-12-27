//
//  SignUpStack.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct SignUpStack: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    
    @ObservedObject var viewModel : SignUpViewModel
    
    @State private var checkEntry : Bool = false
    
    @State private var goToCountrySetUp : Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Create")
                    Text("an account")
                }
                .modifier(FontModifier(color: .darkGreySoft, size: .h1, type: .bold))
                
                Spacer()
            }
            
            //MARK: Outlets
            VStack (alignment: .leading, spacing: 20) {
                
                IconTextField(icon: .person, placeHolder: "Name", text: $viewModel.name, isMandatory: true, errorMessage: "Please enter a name", checkEntry: checkEntry)
                
                IconTextField(icon: .mail, placeHolder: "Email", text: $viewModel.email, isMandatory: true, errorMessage: "Please enter a valid email", checkEntry: checkEntry)
                
                IconTextFieldPassword(icon: .lock, placeHolder: "Password", text: $viewModel.password, isMandatory: true, errorMessage: "Please enter a Password", checkEntry: checkEntry)
                
                HStack {
                    Image(systemName: viewModel.agreedToTerms ? SystemIcons.selectedCheckbox.rawValue : SystemIcons.deselectedCheckbox.rawValue)
                        .background(viewModel.agreedToTerms ? Color.cWhite : Color.cGreyMedium)
                        .foregroundColor(viewModel.agreedToTerms ? .cRed : .clear)
                        .cornerRadius(3)
                        .onTapGesture {
                            viewModel.agreedToTerms.toggle()
                        }
                    
                    HStack (spacing: 2) {
                        Text("I have read the ")
                            .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .regular))
                        Text("Terms & Agreement")
                            .modifier(FontModifier(color: .cRed, size: .label, type: .bold))
                    }
                    
                    
                }
                .padding(.vertical)
                
                
            }
            
            
            Spacer()
            
            //MARK: CTAs
            Group {
                
                Button(action: {
                    
                    DispatchQueue.main.async {
                        userProfile.name = viewModel.name
                        userProfile.email = viewModel.email
                    }
                    
                    goToCountrySetUp.toggle()
                    
                    
                }, label: {
                    CTARed(label: "Sign Up")
                })
                
                
                Text("Or sign up with")
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
                
            }
            
            NavigationLink(isActive: $goToCountrySetUp, destination: {
                
                CountrySetupScreen()
                
            }, label: {
                EmptyView()
            })
            
        }
        .environmentObject(userProfile)
    }
}

struct SignUpStack_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStack(viewModel: SignUpViewModel())
    }
}
