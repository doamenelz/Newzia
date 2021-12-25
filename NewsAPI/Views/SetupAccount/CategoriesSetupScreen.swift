//
//  TopicsSetupScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct CategoriesSetupScreen: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @State private var search : String = ""
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack {
            Color.cWhite
             
            VStack {
                NavigationHeader(title: "Follow Categories")
                
                IconTextField(icon: .search, placeHolder: "Search for a Category", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                
                ScrollView (showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(search != "" ? Category.categories.filter({$0.type.rawValue.uppercased().contains(search.uppercased())}) : Category.categories) { category in

                            CategoryCell(category: category, isSelected: viewModel.selectedCategories.contains(where: {$0.type == category.type}) ? true : false)
                                .onTapGesture {
                                    
                                    withAnimation {
                                        if !viewModel.selectedCategories.contains(where: {$0.type == category.type}) {
                                            viewModel.selectedCategories.append(category)
                                            print(viewModel.selectedCategories)
                                        } else {
                                            viewModel.selectedCategories.removeAll(where: {$0.type == category.type})
                                            print(viewModel.selectedCategories)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                }

                        }
                    })
                        .padding(.bottom, 60)

                }
                
                
            }
            .padding()
            
            VStack {
                Spacer()
                
                NavigationLink(destination: {
                    
                }, label: {
                    
                    CTA(label: "Next")
                        .opacity(viewModel.selectedCategories.isEmpty ? 0.95 : 1)
                    
                })
                    .disabled(viewModel.selectedCategories.isEmpty ? true : false)
                    .padding()
                    .padding(.bottom, 10)
                    .background(BlurView(style: .systemUltraThinMaterial))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
}

struct CategoriesSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSetupScreen(viewModel: AccountSetupViewModel())
    }
}


