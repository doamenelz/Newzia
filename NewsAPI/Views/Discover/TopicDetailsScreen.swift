//
//  TopicDetailsScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-06.
//

import SwiftUI

struct TopicDetailsScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject private var viewModel = TopicsViewModel()
    
    @State private var openURLView : Bool = false
    
    var topic : String
    
    
    var body: some View {
        
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationHeader()
                    .padding(.horizontal)
                
                HStack {
                    VStack {
                        Text("#\(topic)")
                            .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .medium))
                            
                        Text(viewModel.checkForMatch(topics: userProfile.topics, topic: topic) ?  "Following" : "+Follow")
                            .modifier(FontModifier(color: viewModel.checkForMatch(topics: userProfile.topics, topic: topic) ? .greyLBlueMedDark : .white, size: .body, type: .medium))
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                            .background(viewModel.checkForMatch(topics: userProfile.topics, topic: topic) ? Color.darkGreySoft : Color.cRed)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .onTapGesture {
                                withAnimation {
                                    if viewModel.checkForMatch(topics: userProfile.topics, topic: topic) {
                                        
                                        userProfile.topics.removeAll(where: {$0.uppercased() == topic.uppercased()})
                                        
                                    } else {
                                        
                                        userProfile.topics.append(topic)
                                        
                                    }
                                }
                            }
                        
                    }
                    .padding([.horizontal])
                    .padding(.bottom, 10)
                    
                    Spacer()
                }
                
                
                ScrollView {
                    
                    
                    if viewModel.apiResponse != nil {
                        
                        
                        if viewModel.apiResponse!.success {
                            
                            
                            VStack {
                                
                                NewsListItems(allNews: viewModel.allNews, selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: false)
                                
                            }
                            .padding()
                        }
                        
                    }
                    
                    
                    
                }
                .onAppear(perform: {
                    
                    viewModel.searchHeadlines(sources: userProfile.sources, language: userProfile.language, topic: topic, sortBy: userProfile.sortParameter)
                    
                    
                })
                .sheet(isPresented: $openURLView, onDismiss: {
                    
                }, content: {
                    NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "www.apple.com", news: viewModel.selectedNews)
                })
                
            }
            
            if viewModel.apiResponse == nil {
                CircularLoad()
            }
            
        }
        .hideNavigationBar()
    }
}

struct TopicDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopicDetailsScreen(topic: "Bitcoin").environmentObject(UserProfile()).preferredColorScheme(.dark)
    }
}


