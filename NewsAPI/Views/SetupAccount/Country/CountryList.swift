//
//  CountryList.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-26.
//

import SwiftUI

struct CountryList: View {
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @ObservedObject var countryClass : CountryModel
    
    @Binding var search : String
    
    var body: some View {
        ScrollView {
            
            LazyVStack (alignment: .leading) {
                
                Text("What is your country?")
                    .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
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

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList(viewModel: AccountSetupViewModel(), countryClass: CountryModel(), search: .constant(""))
    }
}
