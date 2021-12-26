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
        ZStack {
            Color.cWhite
            
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

struct CountrySetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        CountrySetupScreen()
    }
}




//MARK: - Internal Components -
fileprivate struct CountryCell: View {
    
    var country : Country
    
    var isSelected : Bool
    
    var body: some View {
        
        HStack (alignment: .center) {
            Image(country.code.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .cornerRadius(3)
            
            Text(country.code)
                .modifier(FontModifier(color: isSelected ? .cGreyMedium : .cBlueDark, size: .label, type: .light))
            Text(country.name)
                .modifier(FontModifier(color: isSelected ? .cWhite : .cBlueDark, size: .body, type: .medium))
            
            Spacer()
            
            Image(systemName: isSelected ? SystemIcons.selectedCheckbox.rawValue : SystemIcons.deselectedCheckbox.rawValue)
                .foregroundColor(isSelected ? .cRed : .cWhite)
 
        }
        .padding()
        .background(isSelected ? Color.cBlueDark : .clear)
        .cornerRadius(17)
    }
}

fileprivate struct NextCTA: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: {
                CategoriesSetupScreen(viewModel: viewModel)
            }, label: {
                
                CTA(label: "Next")
                    .opacity(viewModel.selectedCountry != nil ? 1 : 0.8)
                
            })
                .disabled(viewModel.selectedCountry != nil ? false : true)
            
        }
        .padding(.horizontal)
    }
}

fileprivate struct CountryList: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @ObservedObject var countryClass : CountryModel
    
    @Binding var search : String
    
    var body: some View {
        ScrollView {
            
            LazyVStack (alignment: .leading) {
                
                Text("What is your country?")
                    .modifier(FontModifier(color: .cBlueDark, size: .large, type: .bold))
                    .padding(.top)
                
                ForEach (search == "" ? countryClass.countries : countryClass.countries.filter({$0.name.uppercased().contains(search.uppercased())}), id: \.self) { country in
                    
                    Button(action: {
                        
                        withAnimation {
                            viewModel.selectedCountry = country
                        }
                        
                    }, label: {
                        CountryCell(country: country, isSelected: country.code == viewModel.selectedCountry?.code ? true : false)
                    })
                }
                
            }
        }
    }
}
