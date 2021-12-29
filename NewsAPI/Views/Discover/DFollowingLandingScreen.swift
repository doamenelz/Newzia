//
//  DFollowingLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct DFollowingLandingScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var searchedText : String = ""
    
    @State private var isLoading : Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading) {
                NavigationHeader()
                    .padding(.horizontal)
                
                VStack (alignment: .leading) {
                    Text("Sources")
                        .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                    Text("\(userProfile.sources.count) Following")
                        .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                IconTextField(icon: .search, placeHolder: "Search for sources", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false).padding(.horizontal)
                
                
                ScrollView {
                    LazyVStack (spacing: 20) {
                        
                        ForEach(searchedText == "" ? userProfile.sources : userProfile.sources.filter({$0.name.uppercased().contains( searchedText.uppercased())}), id: \.self) { source in
                            
                            NavigationLink(destination: {
                                SourceProfilePage(source: source)
                            }, label: {
                                DiscoverSourcesCell(source: source)
                                    .padding(.all, 10)
                            })
                            
                        }
                        
                    }
                    .padding()
                    .padding(.bottom, 60)
                    
                }
                                
            }
            
            
            
        }
        .hideNavigationBar()
    }
}

struct DFollowingLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DFollowingLandingScreen().environmentObject(UserProfile()).preferredColorScheme(.dark)
    }
}


