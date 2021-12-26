//
//  CategoriesList.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-26.
//

import Foundation
import SwiftUI

struct CategoriesList: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @Binding var search : String
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
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
}

