//
//  ProfileCountrySetup.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-08.
//

import Foundation
import SwiftUI

struct ProfileCountrySetUp: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject var countryClass = CountryModel()
    
    @State private var search : String = ""
    
    @Binding var dismiss : Bool
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                NavigationHeader(title: "Country Selection")
                
                IconTextField(icon: .search, placeHolder: "Search Country", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                
                ScrollView {
                    ForEach (search == "" ? countryClass.countries : countryClass.countries.filter({$0.name.uppercased().contains(search.uppercased())}), id: \.self) { country in
                        
                        Button(action: {
                            
                            withAnimation {
                                
                                userProfile.country = country
                                
                                Country.persistCountry(country: country)
                                
                                dismiss.toggle()
                                
                            }
                            
                        }, label: {
                            CountryCell(country: country, isSelected: country.code.uppercased() == userProfile.country.code.uppercased() ? true : false)
                        })
                    }
                }
                
                
            }
            .padding()
            .onAppear(perform: {
                
                if countryClass.localData != nil {
                    
                    countryClass.parse(jsonData: countryClass.localData!)
                }
                
            })
            
            
        }
    }
        
}

