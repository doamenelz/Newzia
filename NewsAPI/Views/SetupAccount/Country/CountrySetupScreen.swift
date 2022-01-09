//
//  CountrySetupScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-24.
//

import SwiftUI

struct CountrySetupScreen: View {
    
    
    @StateObject var countryClass = CountryModel()
    
    @StateObject var viewModel = AccountSetupViewModel()
    
    @State private var search : String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.whiteBlueDark
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 10){
                    
                    NavigationHeader(title: "Country Selection")
                    
                    IconTextField(icon: .search, placeHolder: "Search Country", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                    
                    CountryList(viewModel: viewModel, countryClass: countryClass, search: $search)
                    
                }
                .padding()
                .padding(.bottom, 40)
                .onAppear(perform: {
                    
                    if countryClass.localData != nil {
                        
                        countryClass.parse(jsonData: countryClass.localData!)
                    }
                    
                })
                
                
                NextCTA(viewModel: viewModel)
                
            }
            .hideNavigationBar()
        }
        
    }
        
}

struct CountrySetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        CountrySetupScreen()
    }
}




//MARK: - Internal Components -

fileprivate struct NextCTA: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: {
                CategoriesSetupScreen(viewModel: viewModel)
            }, label: {
                
                CTARed(label: "Next")
                    .opacity(viewModel.selectedCountry != nil ? 1 : 0.8)
                
            })
                .disabled(viewModel.selectedCountry != nil ? false : true)
            
        }
        .padding(.horizontal)
    }
}


