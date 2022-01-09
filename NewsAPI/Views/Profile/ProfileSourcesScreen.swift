//
//  ProfileSourcesScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation
import SwiftUI

struct ProfileSourcesScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var searchedText : String = ""
    
    @State private var isLoading : Bool = false
    
    @State private var toggleAddSources : Bool = false
    
    @State private var showFollowing : Bool = true
    
    @State private var sources = [Source]()
    
    @Binding var dismiss : Bool
    
    var body: some View {
        
        NavigationView {
          
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading) {
                    NavigationHeaderSheetStyle(dismiss: $dismiss)
                        .padding(.horizontal)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Sources")
                                .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                            Text("\(userProfile.sources.count) Following")
                                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                        }
                        
                        Spacer()

                    }
                    .padding(.horizontal)
                .padding(.bottom, 10)
                    
                    IconTextField(icon: .search, placeHolder: "Search for sources", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false).padding(.horizontal)
                    
                    HStack (spacing: 10) {
                        
                        FilterTab(label: "Following", isSelected: showFollowing)
                            .onTapGesture {
                                showFollowing.toggle()
                                sources = sortBy().sorted(by: {$0.name < $1.name})
                                
                            }
                        
                        FilterTab(label: "Not Following", isSelected: !showFollowing)
                            .onTapGesture {
                                showFollowing.toggle()
                                sources = sortBy().sorted(by: {$0.name < $1.name})
                            }
                        
                        Spacer()
                    }
                    .padding([.leading, .top])
                    
                    
                    ScrollView {
                        LazyVStack (spacing: 20) {
                            
                            ForEach(searchedText == "" ? sources : sources.filter({$0.name.uppercased().contains( searchedText.uppercased())}), id: \.self) { source in
                                
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
                .onAppear(perform: {
                    sources = sortBy()//userProfile.sources
                })
                
                
                
            }
            .hideNavigationBar()
            
        }
        
    }
}

extension ProfileSourcesScreen {
    
    func sortBy () -> [Source] {
        
        if showFollowing {
            
            return userProfile.sources//.sorted(by: {$0.name < $1.name})
            
        } else {
            
            return allAppSources.filter{ !userProfile.sources.contains($0) }
            
        }
        
        
    }
    
    
}


