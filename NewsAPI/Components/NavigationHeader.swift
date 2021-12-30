//
//  NavigationHeader.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct NavigationHeader: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var title : String?
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Image(systemName: SystemIcons.arrowRight.rawValue)
                    .padding([.trailing, .vertical])
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
            }
            
            if title != nil {
                Text(title!)
                    .modifier(FontModifier(color: .cBlueDark, size: .body, type: .bold))
            }
            
        }
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeader()
    }
}





struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}

extension View {
    func hideNavigationBar() -> some View {
        modifier(HideNavigationBarModifier())
    }
}
