//
//  SourceProfilePage.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct SourceProfilePage: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var source : Source
    
    @StateObject var viewModel = SourcesProfilePageViewModel()
    
    @State private var openURLView : Bool = false
    
    @State private var goToSourceWeb : Bool = false
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationHeader()
                    .padding(.horizontal)
                
                ScrollView {
                    
                    HStack (spacing: 10) {
                        
                        WebImage(url: URL(string: K.URLs.clearBit + source.url))
                            .resizable()
                            .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text(source.name)
                                .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                            Text(source.category.capitalized)
                                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
                            Text(viewModel.checkForFollow(source: source, sources: userProfile.sources) ? "Following" : "+ Follow")
                                .modifier(FontModifier(color: viewModel.checkForFollow(source: source, sources: userProfile.sources) ? .greyLBlueMedDark : .white, size: .body, type: .medium))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 40)
                                .background(viewModel.checkForFollow(source: source, sources: userProfile.sources) ? Color.darkGreySoft : Color.cRed)
                                .cornerRadius(20, antialiased: true)
                                .onTapGesture {
                                    
                                    if viewModel.checkForFollow(source: source, sources: userProfile.sources) {
                                        //Unfollow
                                        
                                        DispatchQueue.main.async {
                                            userProfile.sources.removeAll(where: {$0.id == source.id})
                                        }
                                        
                                        DispatchQueue.global(qos: .userInitiated).async {
                                            Source.persistSource(sources: userProfile.sources)
                                        }
                                        
                                        
                                        
                                        
                                    } else {
                                        
                                        DispatchQueue.main.async {
                                            userProfile.sources.append(source)
                                        }
                                        
                                        DispatchQueue.global(qos: .userInitiated).async {
                                            Source.persistSource(sources: userProfile.sources)
                                            
                                        }
                                        
                                        //Follow
                                    }
                                    
                                }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    VStack (alignment: .leading, spacing: 15) {
                        Text(source.description)
                            .lineSpacing(2)
                            .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .regular))
                        
                        HStack {
                            Image(systemName: "link.circle.fill")
                                    .foregroundColor(.blue)
                               // .padding()
                            
                            Text(source.url)
                                .modifier(FontModifier(color: .blue, size: .body, type: .medium))
                        }
                        .onTapGesture {
                            goToSourceWeb.toggle()
                        }
                        .sheet(isPresented: $goToSourceWeb, onDismiss: {
                            
                        }, content: {
                            NewsWebView(dismiss: $goToSourceWeb, webLink: source.url)
                        })
                        
                        
                        
                    }
                    .padding()
                    
                    if viewModel.apiResponse != nil {
                        if viewModel.apiResponse!.success {
                            HStack {
                                Text("Top Headlines")
                                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .extraBold))
                                Spacer()
                            }
                            .padding([.leading, .top])
                            
                            NewsListItems(allNews: viewModel.allNews, selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: false)
                                .sheet(isPresented: $openURLView, onDismiss: {
                                    
                                }, content: {
                                    NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com")
                                })
                            
                        }
                    }
                    
                    
                }
                .onAppear(perform: {
                    DispatchQueue.global(qos: .userInitiated).async {
                        viewModel.topHeadlines(sources: [source], language: source.language)
                    }
                })
            }
            .hideNavigationBar()
            
        }
    }
}

struct SourceProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        SourceProfilePage(source: Source.sampleSources[0]).environmentObject(UserProfile()).preferredColorScheme(.light)
    }
}
