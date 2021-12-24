//
//  VerificationStack.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct VerificationStack: View {
    @ObservedObject var viewModel : ResetPasswordViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                VStack (alignment: .leading, spacing: 20) {
                    Text("Verification")
                        .modifier(FontModifier(color: .cBlueDark, size: .h1, type: .bold))
                    Text("Enter the verification code sent to your email")
                        .modifier(FontModifier(color: .cBlueMedium, size: .body, type: .medium))
                }
                
                Spacer()
            }
            
            OTPField(placeHolder: "Code", text: $viewModel.verificationPasscode)
                .padding(.vertical, 20)
            
            Spacer()
            
            VStack (spacing: 20) {
                HStack (spacing: 3) {
                    Text("Haven't received the code? ")
                        .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
                    Text("Resend Code")
                        .modifier(FontModifier(color: .cRed, size: .label, type: .bold))
                }
                .padding(.vertical)
                
                Button(action: {
                    withAnimation {
                        viewModel.sendEmail()
                    }
                    
                }, label: {
                    CTA(label: "Verify")
                })
                
            }
            
        }
    }}

struct VerificationStack_Previews: PreviewProvider {
    static var previews: some View {
        VerificationStack(viewModel: ResetPasswordViewModel())
    }
}
