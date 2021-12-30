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
    
    @State private var selectedCategory : String = "Latest"
    
    @State private var openURLView : Bool = false
    
    
    var body: some View {
        
        NavigationView {
            
        
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                if isLoading {
                    
                    CircularLoad()
                    
                } else {
                    
                    if viewModel.apiResponse!.success {
                        
                        VStack {
                            
                            NewsLandingHeader()
                            
                            SectionHeader(selectedCategory: $selectedCategory)
                            
                            NewsList(viewModel: viewModel, selectedCategory: $selectedCategory, openURLView: $openURLView)
                            
                            
                            
                        }
                        .padding()
                        
                        
                        
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
}

struct NewsLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsLandingScreen().environmentObject(UserProfile())//.preferredColorScheme(.dark)
    }
}




struct FilterTab: View {
    
    var label : String
    
    var isSelected : Bool
    
    var body: some View {
        Text(label)
            .modifier(FontModifier(color: isSelected ? .white : .darkGreySoft, size: .label, type: isSelected ? .bold : .medium))
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(isSelected ? Color.blueRed : .clear)
            .cornerRadius(20)
    }
}

struct CategoryFilter: View {
    
    var label : String
    var isSelected : Bool
    
    var body: some View {
        HStack {
            Spacer()
            FilterTab(label: label, isSelected: isSelected)
            Spacer()
            Divider()
                .frame(height: 24)
        }
        .frame(maxWidth: K.Dimensions.frameWidth / 3)
    }
}


//MARK: - Internal Components -

fileprivate struct SectionHeader: View {
    
    @Binding var selectedCategory : String
    
    @EnvironmentObject var userProfile : UserProfile
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            
            HStack {
                
                CategoryFilter(label: "Latest", isSelected: selectedCategory.uppercased() == "Latest".uppercased() ? true : false)
                    .onTapGesture {
                        //withAnimation {
                            selectedCategory = "Latest"
                        //}
                    }
                
                ForEach(userProfile.categories, id: \.self) { category in
                    CategoryFilter(label: category.type, isSelected: selectedCategory.uppercased() == category.type.uppercased())
                        .onTapGesture {
                           // withAnimation {
                                selectedCategory = category.type
                           // }
                        }
                }
                
                
            }
            .padding(.top)
            .padding(.bottom, 10)
            
            
        }
    }
}

fileprivate struct NewsLandingHeader: View {
    var body: some View {
        HStack {
            Image(AppAssets.SplashScreen.text)
            
            Spacer()
            
            Image(systemName: SystemIcons.bell.rawValue)
                .padding(.horizontal)
        }
        .padding(.leading)
    }
}

fileprivate struct NewsList: View {
    
    @ObservedObject var viewModel : NewsLandingViewModel
    
    @Binding var selectedCategory : String
    
    @Binding var openURLView : Bool
    
    var body: some View {
        ScrollView {
            
            VStack (spacing: 20) {
                
                if !viewModel.topHeadlines.isEmpty {
                    
                    NewsLandingHero(news: selectedCategory == "Latest".uppercased() ? viewModel.topHeadlines.first! : viewModel.topHeadlines.filter({$0.category.rawValue.uppercased() == selectedCategory.uppercased()}).first ?? viewModel.topHeadlines.first!, small: false)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                viewModel.selectedNews = viewModel.topHeadlines.first!
                            }
                            
                            if viewModel.topHeadlines.first!.news.url != "" {
                                openURLView.toggle()
                            }
                            
                        }
                    
                    
                    NewsListItems(allNews: selectedCategory == "Latest" ? viewModel.topHeadlines : viewModel.topHeadlines.filter({$0.category.rawValue.uppercased() == selectedCategory.uppercased()}), selectedNews: $viewModel.selectedNews, openURLView: $openURLView, hideFirst: true)
                    
                }
                
            }
            .padding(.horizontal)
            //.padding()
            .padding(.bottom, 40)
        }
        .sheet(isPresented: $openURLView, onDismiss: {
            
        }, content: {
            NewsWebView(dismiss: $openURLView, webLink: viewModel.selectedNews?.news.url ?? "https://www.apple.com")
        })
    }
}
