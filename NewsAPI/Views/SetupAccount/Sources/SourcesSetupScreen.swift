//
//  SourcesSetupScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct SourcesSetupScreen: View {
    
    @StateObject var sourcesViewModel = SourcesModel()
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @State private var search : String = ""
    
    
    
    var body: some View {
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            VStack {
                
                NavigationHeader(title: "Select Sources")
                
                IconTextField(icon: .search, placeHolder: "Search for a Source", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                
                SourcesList(viewModel: viewModel, sourcesViewModel: sourcesViewModel, search: $search)
                
            }
            .padding()
            
            NextCTA(viewModel: viewModel)
            
        }
        .onAppear(perform: {
            
            if sourcesViewModel.localData != nil {
                sourcesViewModel.parse(jsonData: sourcesViewModel.localData!, category: viewModel.selectedCategories)
            }
            
        })
        .hideNavigationBar()
    }
}

struct SourcesSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SourcesSetupScreen(viewModel: AccountSetupViewModel())
    }
}


//MARK: - Internal Components -

fileprivate struct NextCTA: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: {
                ProfileSetupScreen(viewModel: viewModel)
                
            }, label: {
                
                CTARed(label: "Next")
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

