//
//  DFollowingLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct DFollowingLandingScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject var viewModel = DiscoverFollowingViewModel()
    
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
                    
                    if viewModel.apiResponse != nil {
                        
                        if viewModel.apiResponse!.success {
                            LazyVStack (spacing: 20) {
                                
                                ForEach(searchedText == "" ? viewModel.following : viewModel.following.filter({$0.source.name.uppercased().contains( searchedText.uppercased())})) { source in
                                    DiscoverSourcesCell(source: source)
                                        .padding(.all, 10)
                                        .onTapGesture {
                                            //Goto Profile
                                        }
                                    
                                }
                                
                            }
                            .padding()
                            .padding(.bottom, 60)
                        }
                        
                    }
                    
                }
                                
            }
            
            if viewModel.apiResponse == nil {
                CircularLoad()
                    .onAppear(perform: {
                        print("------SOurces landing just appeared")
                        DispatchQueue.global(qos: .userInitiated).async {
                            print("Im on the background thread")
                            viewModel.getRecentNews(sources: userProfile.sources, language: userProfile.preferredNewsLanguage)
  
                            
                        }
                        
                    })
            }
            
        }
        .hideNavigationBar()
    }
}

struct DFollowingLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DFollowingLandingScreen(viewModel: DiscoverFollowingViewModel()).environmentObject(UserProfile()).preferredColorScheme(.dark)
    }
}


