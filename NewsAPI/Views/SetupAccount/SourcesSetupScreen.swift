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
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack {
            
            Color.cWhite
            VStack {
                
                NavigationHeader(title: "Select Sources")
                
                IconTextField(icon: .search, placeHolder: "Search for a Source", text: $search, isMandatory: false, errorMessage: "", checkEntry: false)
                
                
                ScrollView {
                    
                    if !sourcesViewModel.sources.isEmpty {
                        
                        LazyVGrid(columns: columns, content: {
                            ForEach(search == "" ? sourcesViewModel.sources : sourcesViewModel.sources.filter({$0.name.uppercased().contains(search.uppercased())}), id: \.self) {source in
                                
                                SourcesCell(source: source, isSelected: viewModel.selectedSources.contains(source) ? true : false)
                                    .onTapGesture {
                                        
                                        withAnimation {
                                            
                                            if viewModel.selectedSources.contains(source) {
                                                viewModel.selectedSources.removeAll(where: {$0.id == source.id})
                                            } else {
                                                viewModel.selectedSources.append(source)
                                            }
                                            
                                        }
                                        
                                    }
                                
                            }
                            
                            
                        })
                        
                    }
                    
                }
                
                
            }
            .padding()
            
            VStack {
                Spacer()
                
                NavigationLink(destination: {
                    ProfileSetupScreen(viewModel: viewModel)
                    
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
        .onAppear(perform: {
            
            if sourcesViewModel.localData != nil {
                sourcesViewModel.parse(jsonData: sourcesViewModel.localData!)
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
