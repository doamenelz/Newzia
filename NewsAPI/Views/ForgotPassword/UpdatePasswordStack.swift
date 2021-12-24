//
//  UpdatePasswordStack.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct UpdatePasswordStack: View {
    @ObservedObject var viewModel : ResetPasswordViewModel
    
    @State private var checkEntry : Bool = false
    
    var body: some View {
        VStack {
            Image(AppAssets.ForgotPassword.security)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: K.Dimensions.frameWidth / 3)
            
            .padding(.bottom, 40)
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Update")
                    Text("Password")
                }
                .modifier(FontModifier(color: .cBlueDark, size: .h1, type: .bold))
                
                Spacer()
            }
            
            VStack (spacing: 20) {
                IconTextFieldPassword(icon: .lock, placeHolder: "New Password", text: $viewModel.newPassword, isMandatory: true, errorMessage: "Please enter a password", checkEntry: checkEntry)
                
                IconTextFieldPassword(icon: .lock, placeHolder: "Repeat Password", text: $viewModel.repeatPassword, isMandatory: true, errorMessage: "Passwords do not match", checkEntry: checkEntry)
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                CTA(label: "Submit")
            })
            
            
        }
    }}

struct UpdatePasswordStack_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordStack(viewModel: ResetPasswordViewModel())
    }
}
