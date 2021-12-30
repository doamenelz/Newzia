//
//  CategoryNewsPage.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import SwiftUI

struct CategoryNewsPage: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var category : Category
    
    @StateObject private var viewModel = CategoryNewsPageViewModel()
    
    @State private var openURLView : Bool = false
    
    @StateObject private var newsListViewModel = NewsListViewModel()
    
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationHeader()
                    .padding(.horizontal)
                
                ScrollView {
                    
                    VStack {
                        
                        CategoryHeader(category: category, count: viewModel.allNews.count)
                            .padding(.bottom)
                        
                        if viewModel.apiResponse != nil {
                            if viewModel.apiResponse!.success {
                                
                                if !viewModel.allNews.isEmpty {
                                    
                                    NewsLandingHero(news: viewModel.allNews.first!, small: true)
                                        .onAppear(perform: {
                                            newsListViewModel.allNews = viewModel.allNews
                                        })
                                        .onTapGesture {
                                            
                                            DispatchQueue.main.async {
                                                viewModel.selectedNews = viewModel.allNews.first!
                                            }
                                            
                                            
                                            
                                            if viewModel.allNews.first!.news.url != "" {
                                                openURLView.toggle()
                                            }
                                            
                                        }
                                        .sheet(isPresented: $openURLView, onDismiss: {
                                            
                                        }, content: {
                                            NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com")
                                        })
                                    
                                    HStack {
                                        Text("Top News")
                                            .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .extraBold))
                                        Spacer()
                                    }
                                    .padding([.leading, .top])
                                    
                                    
                                    if viewModel.allNews.count > 1 {
                                        NewsListItems(allNews: viewModel.allNews, selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: true)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .onAppear(perform: {
                DispatchQueue.global(qos: .userInitiated).async {
                    viewModel.topHeadlines(sources: userProfile.sources.filter({$0.category.uppercased() == category.type.uppercased() }))
                    
                }
            })
        }
        .hideNavigationBar()
    }
}

struct CategoryNewsPage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryNewsPage(category: Category(type: CategoryTypes.sports.rawValue)).preferredColorScheme(.light).environmentObject(UserProfile())
    }
}

fileprivate struct CategoryHeader: View {
    
    var category : Category
    var count : Int
    
    var body: some View {
        ZStack {
            Image(category.type)
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .modifier(HeroGradient())
            
            VStack {
                Spacer()
                HStack {
                    VStack (alignment: .center, spacing: 5) {
                        Text(category.type)
                            .modifier(FontModifier(color: .white, size: .large, type: .bold))
                        Text("\(count) News")
                            .modifier((FontModifier(color: .white, size: .body, type: .light)))
                    }
                    .frame(maxWidth: .infinity)
                    
                    //Spacer()
                    
                }
                Spacer()
            }
            .background(Color.black.opacity(0.9))
            
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
