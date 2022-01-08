//
//  ProfileCategoriesList.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-08.
//

import Foundation
import SwiftUI

struct ProfileCategoriesList: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var categories = [Category]()
    
    @Binding var dismiss : Bool
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        
        ZStack {
            VStack {
                NavigationHeader(title: "Update Categories")
                    .padding([.horizontal, .top])
                
                ScrollView (showsIndicators: false) {
                    
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        
                        ForEach(Category.categories, id: \.self) { category in
                            
                            CategoryCell(category: category, isSelected: categories.contains(where: {$0.type == category.type}) ? true : false)
                                .onTapGesture {
                                    
                                    withAnimation {
                                        if !categories.contains(where: {$0.type == category.type}) {
                                            
                                            categories.append(category)
                                            
                                        } else {
                                            
                                            categories.removeAll(where: {$0.type == category.type})
                                            
                                        }
                                    }
                                    
                                    
                                    
                                }
                            
                        }
                    })
                        .padding(.bottom, 60)
                    
                }
                //.padding()
            }
            
            VStack {
                Spacer()
                
                    
                CTARed(label: "Update")
                    .opacity(categories.isEmpty ? 0.95 : 1)
                    .disabled(categories.isEmpty ? true : false)
                    .padding()
                    .padding(.bottom, 10)
                    .background(BlurView(style: .systemUltraThinMaterial))
                    .onTapGesture {
                        if !categories.isEmpty {
                            userProfile.categories = categories
                            
                            Category.persistCategories(categories: categories)
                            
                            dismiss.toggle()
                        }
                        
                        
                    }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(perform: {
            categories = userProfile.categories
        })
    }
}
