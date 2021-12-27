//
//  TextFields.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct TextFields: View {
    
    @State private var text : String = "1234567"
    @State private var checkEntry : Bool = true
    
    var body: some View {
        OTPField(placeHolder: "Passcode", text: $text)
    }
}

struct TextFields_Previews: PreviewProvider {
    static var previews: some View {
        TextFields()
    }
}


struct IconTextField : View {
    
    var icon : SystemIcons
    var placeHolder : String
    @Binding var text : String
    var isMandatory : Bool
    var errorMessage : String
    var checkEntry : Bool
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            HStack {
                
                Image(systemName: icon.rawValue)
                    .foregroundColor(.cBlueMedium)
                    .font(.caption)
                TextField(placeHolder, text: $text)
                    .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
                Spacer()
                
                if text != "" {
                    Image(systemName: SystemIcons.clearText.rawValue)
                        .foregroundColor(.cBlueMedium)
                        .onTapGesture {
                            text = ""
                        }
                }
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.greyBlueMedDark)
            .cornerRadius(18)
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).strokeBorder().foregroundColor((checkEntry && text == "") ? .cRed : .clear))
            
            if isMandatory {
                if (checkEntry && text == "") {
                    Text(errorMessage)
                        .modifier(FontModifier(color: .cRed, size: .label, type: .medium))
                }
            }
            
        }
    }
}

struct IconTextFieldPassword : View {
    
    var icon : SystemIcons
    var placeHolder : String
    @Binding var text : String
    var isMandatory : Bool
    var errorMessage : String
    var checkEntry : Bool
    
    @State private var revealPassword : Bool = false
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            ZStack {
                if !revealPassword {
                    HStack {
                        
                        Image(systemName: icon.rawValue)
                            .foregroundColor(.cBlueMedium)
                            .font(.caption)
                        SecureField(placeHolder, text: $text)
                            .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
                        Spacer()
                        
                        if text != "" {
                            Image(systemName: SystemIcons.eye.rawValue)
                                .foregroundColor(.cBlueMedium)
                                .onTapGesture {
                                    revealPassword.toggle()
                                }
                        }
                        
                        
                        
                    }
                    
                } else {
                    HStack {
                        
                        Image(systemName: icon.rawValue)
                            .foregroundColor(.cBlueMedium)
                            .font(.caption)
                        TextField(placeHolder, text: $text)
                            .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
                        Spacer()
                        
                        if text != "" {
                            Image(systemName: SystemIcons.clearText.rawValue)
                                .foregroundColor(.cBlueMedium)
                                .onTapGesture {
                                    text = ""
                                }
                        }
                        
                        
                        
                    }
                }
                
                
            }
            
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.greyBlueMedDark)
            .cornerRadius(18)
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).strokeBorder().foregroundColor((checkEntry && text == "") ? .cRed : .clear))
            
            if isMandatory {
                if (checkEntry && text == "") {
                    Text(errorMessage)
                        .modifier(FontModifier(color: .cRed, size: .label, type: .medium))
                }
            }
            
        }
    }
}

struct OTPField : View {
    
    var placeHolder : String
    
    @Binding var text : String
    
    var body: some View {
        
        TextField(placeHolder, text: $text)
            .multilineTextAlignment(.center)
            .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
            .keyboardType(.numberPad)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.greyBlueMedDark)
            .cornerRadius(18)
        
    }
}
