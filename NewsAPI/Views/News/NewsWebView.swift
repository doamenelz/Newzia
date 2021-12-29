//
//  NewsWebView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct NewsWebView: View {
    
    @State var workState = WebView.WorkState.initial
    
    @Binding var dismiss : Bool
    
    var webLink : String
    
    var body: some View {
        
        ZStack {
            
            VStack (spacing: 0) {
                
                HStack {
                    
                    Image(systemName: SystemIcons.xMark.rawValue)
                        .padding()
                        .onTapGesture {
                            dismiss.toggle()
                        }
                    
                    Spacer()
                    
                    Image(systemName: SystemIcons.bookmark.rawValue)
                        .padding()
                    
                    Link(destination: URL(string: webLink)!) {
                        Image(systemName: "link.circle.fill")
                            .foregroundColor(.darkGreySoft)
                            .padding()
                    }
                    
                    
                }
                .font(.title3)
                .background(Color.whiteBlueDark)
                
                WebView(urlString: webLink, workState: $workState)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            if workState != .done {
                CircularLoad()
            }
            
        }
    }
}

struct NewsWebView_Previews: PreviewProvider {
    static var previews: some View {
        NewsWebView(dismiss: .constant(false), webLink: "https://www.apple.com").preferredColorScheme(.dark)
    }
}
