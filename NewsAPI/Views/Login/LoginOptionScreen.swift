//
//  LoginOptionScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct LoginOptionScreen: View {
    
    @Binding var dismiss : Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.cWhite
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        
                        Image(systemName: SystemIcons.xMark.rawValue)
                            .padding(.vertical)
                            .onTapGesture {
                                dismiss.toggle()
                            }
                        
                        Spacer()
                        
                        Text("Skip")
                            .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
                            .padding()
                        
                    }
                    
                    ZStack {
                        Image(AppAssets.SignIn.hero)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(30)
                        VStack {
                            Image(AppAssets.SignIn.logo)
                                .resizable()
                                .frame(width: 89.52, height: 13)
                                .padding()
                            Spacer()
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("Sign In")
                                    Text("options.")
                                }
                                .modifier(FontModifier(color: .cWhite, size: .h1, type: .bold))
                                .padding()
                                
                                Spacer()
                            }
                            
                        }
                    }
                    //.frame(maxHeight: K.Dimensions.frameHeight / 2)
                    
                    Spacer()
                    
                    VStack (spacing: 15) {
                        
                        NavigationLink(destination: {
                            LoginScreen()
                        }, label: {
                            CTAwIcon(label: "Continue with Email", icon: .mail, primary: true)
                        })
                        
                        
                        Button(action: {
                            
                        }, label: {
                            CTAwIcon(label: "Sign in with Google", icon: .google, primary: false)
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            CTAwIcon(label: "Sign in with Apple", icon: .apple, primary: false)
                        })
                        
                        
                        
                        HStack (spacing: 2) {
                            Text("Don't have an account? ")
                                .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
                            Text("Sign Up")
                                .modifier(FontModifier(color: .cRed, size: .label, type: .bold))
                        }
                        .padding(.vertical, 10)
                    }.layoutPriority(1)
                    
                    Spacer()
                    
                    
                }
                .padding()
            }
            .hideNavigationBar()
        }
    }
}

struct LoginOptionScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginOptionScreen(dismiss: .constant(false))
    }
}
