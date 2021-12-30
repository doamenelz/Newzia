//
//  DiscoverCategoriesLanding.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-30.
//

import SwiftUI

struct DiscoverCategoriesLanding: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationHeader().padding(.horizontal)
                
                ScrollView {
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Categories")
                                .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                            Text("\(userProfile.categories.count) Following")
                                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(userProfile.categories, id: \.self) { category in
                            
                            NavigationLink(destination: {
                                CategoryNewsPage(category: category)
                            }, label: {
                                DiscoverCategoryCell(category: category)
                            })
                            
                            
                        }
                        
                    })
                        .padding()
                        .padding(.bottom, 60)
                    
                }
               
                
            }
        }
        .hideNavigationBar()
    }
}

struct DiscoverCategoriesLanding_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCategoriesLanding().environmentObject(UserProfile())
    }
}

fileprivate struct DiscoverCategoryCell: View {
    
    var category : Category
    
    var body: some View {
        ZStack {
            Image(category.type)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: K.Dimensions.frameWidth / 2.3, height: K.Dimensions.frameHeight / 4)
                .contentShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            VStack {
                
                Spacer()
                
                HStack {
                    Text(category.type)
                        .modifier(FontModifier(color: .cWhite, size: .body, type: .bold))
                    Spacer()
                }
                .padding()
                
                
            }
            .modifier(BottomGradient())
        }
        .frame(width: K.Dimensions.frameWidth / 2.3, height: K.Dimensions.frameHeight / 4)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}
