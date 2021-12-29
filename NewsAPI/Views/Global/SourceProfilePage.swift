//
//  SourceProfilePage.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct SourceProfilePage: View {
    
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
                            Text("+ Follow")
                                .modifier(FontModifier(color: .white, size: .body, type: .medium))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 40)
                                .background(Color.cRed)
                                .cornerRadius(20, antialiased: true)
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
                            LazyVStack (spacing: 20) {
                                ForEach(viewModel.allNews) { news in
                                    
                                    NewsCell(news: news)
                                        .onTapGesture {
                                            
                                            DispatchQueue.main.async {
                                                viewModel.selectedNews = news
                                            }
                                            
                                            
                                            
                                            if news.news.url != "" {
                                                openURLView.toggle()
                                            }
                                            
                                        }
                                        .sheet(isPresented: $openURLView, onDismiss: {
                                            
                                        }, content: {
                                            NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com")
                                        })
                                    
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 60)
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
        SourceProfilePage(source: Source.sampleSources[0]).preferredColorScheme(.dark)
    }
}
