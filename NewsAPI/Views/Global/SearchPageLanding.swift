//
//  SearchPageLanding.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//


//TODO: Make Recent Searches trigger begin search

import SwiftUI

struct SearchPageLanding: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject private var viewModel = SearchPageViewModel()
    
    @State private var openURLView : Bool = false
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationHeader(title: "Search")
                    .padding(.horizontal)
                                
                VStack {
                    HStack {
                        
                        Image(systemName: SystemIcons.search.rawValue)
                            .foregroundColor(.cBlueMedium)
                            .font(.caption)
                        TextField("Search news, or topics", text: $viewModel.searchedText, onCommit: {
                            
                            if viewModel.searchedText != "" {
                                
//                                viewModel.printedSearch = viewModel.searchedText
//                                viewModel.searchInProgress = true
//
//                                userProfile.recentSearches.append(viewModel.searchedText)
//
//                                viewModel.searchHeadlines(sources: userProfile.sources, country: userProfile.country.code.lowercased(), language: userProfile.language)
                                
                                beginSearch()
                                
                            }
                            
                        })
                            .modifier(FontModifier(color: .cBlueDark, size: .body, type: .medium))
                        Spacer()
                        
                        if viewModel.searchedText != "" {
                            Image(systemName: SystemIcons.clearText.rawValue)
                                .foregroundColor(.cBlueMedium)
                                .onTapGesture {
                                    viewModel.searchedText = ""
                                }
                        }
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.greyBlueMedDark)
                    .cornerRadius(18)
                
                    
                    if viewModel.apiResponse != nil {
                        HStack {
                            Spacer()
                            Text("Showing results for \"\(viewModel.printedSearch)\" - \(viewModel.allNews.count) Articles")
                                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                        }
                        .sheet(isPresented: $openURLView, onDismiss: {
                            
                        }, content: {
                            NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "www.apple.com", news: viewModel.selectedNews)
                        })

                    }
                                        
                }
                .padding(.horizontal)
                
                
                
                
                if viewModel.searchInProgress {
                    
                    CircularLoad()
                    
                } else {
                    
                    if viewModel.apiResponse != nil {
                        
                        if viewModel.apiResponse!.success {
                            
                            ScrollView {
                              
                                VStack {
                                  
                                    NewsListItems(allNews: viewModel.allNews, selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: false)
                                    
                                }
                                .padding()
                                
                            }
                            
                            
                            
                        } else {
                            
                            //Failed API czll
                        }
                        
                    } else {
                        
                        ScrollView {
                            
                            if !userProfile.recentSearches.isEmpty {
                             
                                VStack {
                                    
                                    SearchSection(label: "Recent Searches")
                                    
                                    ForEach(userProfile.recentSearches, id: \.self) { value in
                                     
                                        RecentSearch(searchValue: value)
                                        
                                    }
                                    
                                }
                                .padding(.horizontal)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            
        }
        .hideNavigationBar()
    }
}

struct SearchPageLanding_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageLanding().environmentObject(UserProfile())
    }
}

extension SearchPageLanding {
    
    func beginSearch () {
        
        viewModel.printedSearch = viewModel.searchedText
        viewModel.searchInProgress = true
        
        userProfile.recentSearches.append(viewModel.searchedText)
        
        viewModel.searchHeadlines(sources: userProfile.sources, country: userProfile.country.code.lowercased(), language: userProfile.language, sortBy: userProfile.sortParameter)
    }
    
}

fileprivate struct SearchSection: View {
    
    var label : String
    
    var body: some View {
        HStack {
            Text(label)
                .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

fileprivate struct RecentSearch: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var searchValue : String
    
    var body: some View {
        HStack {
            
            Text(searchValue)
                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
            
            Spacer()
            
            Image(systemName: SystemIcons.xMark.rawValue)
                .font(.caption)
                .padding(.all, 5)
                .onTapGesture {
                    userProfile.recentSearches.removeAll(where: {$0.uppercased() == searchValue.uppercased()})
                }
            
        }
        .environmentObject(userProfile)
    }
}
