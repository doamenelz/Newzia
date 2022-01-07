//
//  DiscoverLandingScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-28.
//

import SwiftUI

struct DiscoverLandingScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack (spacing: 20) {
                        DiscoverLandingHeader()
                           
                        
                        NavigationLink(destination: {
                            DiscoverCategoriesLanding()
                        }, label: {
                            DiscoverCell(label: "Categories you follow", image: AppAssets.SplashScreen.productTour1, countLabel: "\(userProfile.categories.count) \(userProfile.categories.count > 1 ? "Categories" : "Category")")
                        })
                        
                        NavigationLink(destination: {
                            DFollowingLandingScreen()
                        }, label: {
                            DiscoverCell(label: "Sources you follow", image: AppAssets.SplashScreen.productTour2, countLabel: "\(userProfile.sources.count) \(userProfile.sources.count > 1 ? "Sources" : "Source")")
                        })
                        
                          
                        NavigationLink(destination: {
                            
                            TopicsListingPage()
                            
                        }, label: {
                            DiscoverCell(label: "#Topics you follow", image: AppAssets.SplashScreen.productTour3, countLabel: "\(userProfile.topics.count >= 1 ? "\(userProfile.topics.count) \(userProfile.topics.count > 1 ? "Topics" : "Topic")" : "You currently do not follow any Topic")")
                            
                        })
                      
                        
                        
                        NavigationLink(destination: {
                            
                            CountryNewsPage(country: userProfile.country)
                            
                        }, label: {
                            DiscoverCellCountry(label: userProfile.country.name, image: AppAssets.SplashScreen.productTour1, country: userProfile.country.code)
                        })
                        
                        
                        
                        
                    }
                    //.padding()
                }
                .padding()
            }
            .hideNavigationBar()
        }
    }
}

struct DiscoverLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverLandingScreen().environmentObject(UserProfile()).preferredColorScheme(.dark)
    }
}


struct DiscoverGradient : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    }
}





//MARK: - Internal Components -

fileprivate struct DiscoverLandingHeader: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 2) {
                Text("Discover")
                    .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                Text("Recent news from")
                    .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .medium))
            }
            Spacer()
            
            NavigationLink(destination: {
                SearchPageLanding()
            }, label: {
                Image(systemName: SystemIcons.search.rawValue)
                    .padding()
                    .foregroundColor(.darkGreySoft)
            })
            
        }
    }
}
