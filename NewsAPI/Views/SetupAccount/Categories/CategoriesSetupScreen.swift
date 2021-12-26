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
    
    var body: some View {
        
        ZStack {
            Color.cWhite
                
             
            VStack {
                NavigationHeader(title: "Follow Categories")
                
                IconTextField(icon: .search, placeHolder: "Search for a Category", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                
                CategoriesList(viewModel: viewModel, search: $search)
                
                
            }
            .padding()
            
            NextCTA(viewModel: viewModel)
            
        }
        .hideNavigationBar()
    }
    
    
}

struct CategoriesSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSetupScreen(viewModel: AccountSetupViewModel())
    }
}




//MARK: - Internal Components -

fileprivate struct NextCTA: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: {
                SourcesSetupScreen(viewModel: viewModel)
                
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

