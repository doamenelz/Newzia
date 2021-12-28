//
//  NewsLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import SwiftUI
import SDWebImageSwiftUI


struct NewsLandingScreen: View {
    
    @StateObject var viewModel = NewsLandingViewModel()
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var isLoading : Bool = true
    
    var body: some View {
        
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                if isLoading {
                    
                    CircularLoad()
                    
                } else {
                    
                    if viewModel.apiResponse!.success {
                        
                        ScrollView {
                            
                            VStack (spacing: 20) {
                                
                                HStack {
                                    Image(AppAssets.SplashScreen.text)
                                    
                                    Spacer()
                                    
                                    Image(systemName: SystemIcons.bell.rawValue)
                                        .padding(.horizontal)
                                }
                                
                                
                                if !viewModel.topHeadlines.isEmpty {
                                    
                                    NewsLandingHero(news: viewModel.topHeadlines.first!)
                                    
                                    LazyVStack (spacing: 15) {
                                        ForEach(viewModel.topHeadlines) { news in
                                            NewsCell(news: news)
                                        }
                                    }
                                    
                                }
                                
                            }
                            .padding()
                            .padding(.bottom, 40)
                        }
                        
                        
                    } else {
                        Text(viewModel.apiResponse!.error?.message ?? "ErrorMessage")
                        
                    }
                   
                }
                
                
            }
            .onAppear(perform: {
                if viewModel.apiResponse == nil {
                    viewModel.getTopHeadlines(sources: userProfile.sources, completion: { response in
                        
                        viewModel.apiResponse = response
                        
                        isLoading = false
                        
                    })
                }
                
            })
            .hideNavigationBar()
        
        
    }
}

struct NewsLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsLandingScreen()//.preferredColorScheme(.dark)
    }
}

struct HeroGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black]), startPoint: .top, endPoint: .bottom))
    }
}

struct NewsLandingHero: View {
    
    var news : News
    
    var body: some View {
        
        ZStack {
            
            WebImage(url: URL(string: news.news.urlToImage))
                .resizable()
                .placeholder(Image(AppAssets.SplashScreen.icon))
                .aspectRatio(contentMode: .fill)
                .transition(.fade(duration: 0.5))
                .frame(width: K.Dimensions.frameWidth - 40, height: K.Dimensions.frameHeight / 2)
            
            
            VStack (alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    Image(systemName: SystemIcons.bookmark.rawValue)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 40, height: 40)
                        .background(Color.cRed)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                HStack {
                    Text(news.category.rawValue)
                        .modifier(FontModifier(color: .white, size: .label, type: .medium))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color.cBlueMedium)
                        .cornerRadius(20)
                    Spacer()
                }
                
                Text(news.news.title)
                    .modifier(FontModifier(color: .white, size: .large, type: .bold))
                
                HStack {
                    WebImage(url: URL(string: K.URLs.clearBit + news.iconURL))
                        .resizable()
                        .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                        .foregroundColor(.cBlueMedium)
                        .background(Color.cWhite)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 25, height: 25)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                    Text(news.news.source.name.uppercased())
                        .modifier(FontModifier(color: .white, size: .body, type: .bold))
                    
                    Spacer()
                    
                    Text("3 Hours ago")
                        .modifier(FontModifier(color: .white, size: .label, type: .regular))
                }
                
            }
            .padding()
            .padding(.bottom, 10)
            .modifier(HeroGradient())
            
            
        }
        .frame(height: K.Dimensions.frameHeight / 2)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct NewsCell: View {
    
    var news : News
    
    var body: some View {
        
        HStack {
            WebImage(url: URL(string: news.news.urlToImage))
                .resizable()
                .placeholder(Image(systemName: SystemIcons.newsIconPlaceholder.rawValue))
                .aspectRatio(contentMode: .fill)
                .transition(.fade(duration: 0.5))
                .frame(width: 80, height: 92)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            
            VStack(alignment: .leading, spacing: 10) {
                Text(news.news.source.name)
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                Text(news.news.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .bold))
                Text("30 min ago")
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .light))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.greyLBlueMedDark)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}
