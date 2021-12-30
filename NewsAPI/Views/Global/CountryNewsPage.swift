//
//  CountryNewsPage.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import SwiftUI

struct CountryNewsPage: View {
    
    var country : Country
    
    //@StateObject private var newsListViewModel = NewsListViewModel()
    
    @StateObject private var viewModel = CountryNewsViewModel()
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var searchedText : String = ""
    
    @State private var openURLView : Bool = false
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationHeader()
                    .padding(.horizontal)
                    
                
                VStack {
                    
                    VStack {
                        
                        HStack {
                            Text("Canada")
                                .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                            Image(country.code.lowercased())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 24)
                            
                            Spacer()
                        }
                        
                        IconTextField(icon: .search, placeHolder: "Search", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false)
                        
                    }.padding([.horizontal, .bottom])
                    
                    
                    
                    ScrollView {
                        
                        if viewModel.apiResponse != nil {
                            
                            if viewModel.apiResponse!.success {
                                
                                NewsListItems(allNews: searchedText == "" ? viewModel.allNews : viewModel.allNews.filter({$0.news.source.name.uppercased().contains(searchedText.uppercased()) || $0.category.rawValue.uppercased().contains(searchedText.uppercased()) || $0.news.title!.uppercased().contains(searchedText.uppercased())}), selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: false)
                                    .padding(.horizontal)
                                    .sheet(isPresented: $openURLView, onDismiss: {
                                        
                                    }, content: {
                                        NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com")
                                    })
                            }
                        }
                    }
                    
                }
                
                .onAppear(perform: {
                    DispatchQueue.global(qos: .userInitiated).async {
                        viewModel.topHeadlines(sources: userProfile.sources, country: userProfile.country.code)
                    }
                })
                
                
            }
            .hideNavigationBar()
            
        }
    }
}

struct CountryNewsPage_Previews: PreviewProvider {
    static var previews: some View {
        CountryNewsPage(country: Country.defaultCountry).environmentObject(UserProfile())
    }
}

